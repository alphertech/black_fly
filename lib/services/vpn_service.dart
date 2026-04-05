import '../models/server_model.dart';

class VPNService {
  bool _isConnected = false;
  String? _currentServerId;

  Future<bool> connect() async {
    // Simulate connection
    await Future.delayed(const Duration(seconds: 2));
    _isConnected = true;
    return true;
  }

  Future<bool> connectToServer(String serverId) async {
    // Simulate connection
    await Future.delayed(const Duration(seconds: 2));
    _isConnected = true;
    _currentServerId = serverId;
    return true;
  }

  Future<bool> disconnect() async {
    // Simulate disconnection
    await Future.delayed(const Duration(milliseconds: 500));
    _isConnected = false;
    _currentServerId = null;
    return true;
  }

  ServerModel? getServer(String serverId) {
    // Return mock server data
    return ServerModel(
      id: serverId,
      country: 'Uganda',
      city: 'Kampala',
      countryCode: 'ug',
      flag: 'ug',
      ping: 24,
      load: 42,
      ip: '197.239.42.186',
      isFavorite: false,
      region: 'africa',
    );
  }

  bool get isConnected => _isConnected;
  String? get currentServerId => _currentServerId;
}