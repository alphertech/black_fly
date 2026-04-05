import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  final StorageService _storage = StorageService();

  AuthProvider() {
    _loadSavedUser();
  }

  Future<void> _loadSavedUser() async {
    final userData = await _storage.getUser();
    if (userData != null) {
      _user = UserModel.fromJson(userData);
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password, bool remember) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Mock login - accept any credentials
    if (email.isNotEmpty && password.isNotEmpty) {
      _user = UserModel(
        id: '1',
        name: email.split('@')[0],
        email: email,
        plan: 'Premium',
        memberSince: 'Jan 2025',
        isPremium: true,
        deviceCount: 3,
        maxDevices: 5,
        totalDataUsed: 65,
        dataLimit: 100,
      );
      
      if (remember) {
        await _storage.saveUser(_user!.toJson());
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    }
    
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      plan: 'Free',
      memberSince: DateTime.now().toString().substring(0, 7),
      isPremium: false,
      deviceCount: 1,
      maxDevices: 3,
      totalDataUsed: 0,
      dataLimit: 10,
    );
    
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void setMockUser() {
    _user = UserModel(
      id: '1',
      name: 'Google User',
      email: 'user@gmail.com',
      plan: 'Premium',
      memberSince: 'Jan 2025',
      isPremium: true,
      deviceCount: 2,
      maxDevices: 5,
      totalDataUsed: 45,
      dataLimit: 100,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.clearUser();
    _user = null;
    notifyListeners();
  }
}