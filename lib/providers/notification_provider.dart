import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/storage_service.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => n.isUnread).length;

  final StorageService _storage = StorageService();

  NotificationProvider() {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final saved = await _storage.getNotifications();
    if (saved != null) {
      _notifications = saved.map((n) => NotificationModel.fromJson(n)).toList();
    } else {
      _addSampleNotifications();
    }
    notifyListeners();
  }

  void _addSampleNotifications() {
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'Security Alert',
        message: 'New login detected from unknown device',
        icon: 'fa-shield',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isUnread: true,
        type: 'warning',
      ),
      NotificationModel(
        id: '2',
        title: 'Server Update',
        message: 'Server maintenance completed successfully',
        icon: 'fa-server',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isUnread: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Welcome',
        message: 'Thanks for choosing SEYTRONS',
        icon: 'fa-heart',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isUnread: false,
      ),
    ];
  }

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    _saveNotifications();
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isUnread: false);
      _saveNotifications();
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isUnread: false)).toList();
    _saveNotifications();
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    _saveNotifications();
    notifyListeners();
  }

  Future<void> _saveNotifications() async {
    await _storage.saveNotifications(_notifications.map((n) => n.toJson()).toList());
  }
}