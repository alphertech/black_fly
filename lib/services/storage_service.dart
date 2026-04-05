import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String _keyUser = 'user_data';
  static const String _keyNotifications = 'notifications';
  static const String _keyFavorites = 'favorites';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await _instance;
    await prefs.setString(_keyUser, json.encode(userData));
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await _instance;
    final data = prefs.getString(_keyUser);
    if (data != null) {
      return json.decode(data);
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await _instance;
    await prefs.remove(_keyUser);
  }

  Future<void> saveNotifications(
    List<Map<String, dynamic>> notifications,
  ) async {
    final prefs = await _instance;
    await prefs.setString(_keyNotifications, json.encode(notifications));
  }

  Future<List<Map<String, dynamic>>?> getNotifications() async {
    final prefs = await _instance;
    final data = prefs.getString(_keyNotifications);
    if (data != null) {
      return List<Map<String, dynamic>>.from(json.decode(data));
    }
    return null;
  }

  Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await _instance;
    await prefs.setStringList(_keyFavorites, favorites);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await _instance;
    return prefs.getStringList(_keyFavorites) ?? [];
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }
}
