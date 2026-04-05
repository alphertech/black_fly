import 'package:flutter/material.dart';
import '../models/server_model.dart';
import 'dart:async';
import '../services/vpn_service.dart';

class VPNProvider extends ChangeNotifier {
  bool _isConnected = false;
  bool _isConnecting = false;
  ServerModel? _currentServer;
  String? _currentIpAddress;
  int _currentPing = 24;
  int _elapsedSeconds = 0;
  Timer? _timer;

  bool get isConnected => _isConnected;
  bool get isConnecting => _isConnecting;
  ServerModel? get currentServer => _currentServer;
  String? get currentIpAddress => _currentIpAddress;
int get currentPing => _currentPing;
  String? get currentLocation => _currentServer?.displayName;
  String? get currentIP => _currentIpAddress;
  double get downloadToday => 1.2; // Mock values
  double get uploadToday => 0.3;
  double get topSpeed => 287.0;
  int get elapsedSeconds => _elapsedSeconds;
  String get formattedElapsedTime {
    final hours = _elapsedSeconds ~/ 3600;
    final minutes = (_elapsedSeconds % 3600) ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void updateLocation(String location, String ip, int ping) {
    _currentIpAddress = ip;
    _currentPing = ping;
    // Update currentServer if needed
    notifyListeners();
  }


  final VPNService _vpnService = VPNService();

  Future<void> toggleConnection() async {
    if (_isConnected) {
      await disconnect();
    } else {
      await connect();
    }
  }

  Future<void> connect() async {
    _isConnecting = true;
    notifyListeners();

    final result = await _vpnService.connect();

    if (result) {
      _isConnected = true;
      _currentIpAddress = '197.239.42.186';
      _startTimer();
    }

    _isConnecting = false;
    notifyListeners();
  }

  Future<void> connectToServer(String serverId) async {
    _isConnecting = true;
    notifyListeners();

    final result = await _vpnService.connectToServer(serverId);

    if (result) {
      _isConnected = true;
      _currentServer = _vpnService.getServer(serverId);
      _currentIpAddress = _currentServer?.ip ?? '197.239.42.186';
      _currentPing = _currentServer?.ping ?? 24;
      _startTimer();
    }

    _isConnecting = false;
    notifyListeners();
  }

  Future<void> disconnect() async {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    await _vpnService.disconnect();

    _isConnected = false;
    _currentServer = null;
    _elapsedSeconds = 0;
    notifyListeners();
  }

  void cancelConnection() {
    _isConnecting = false;
    notifyListeners();
  }

  void _startTimer() {
    _elapsedSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      notifyListeners();
    });
  }
}
