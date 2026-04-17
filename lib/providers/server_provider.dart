import 'package:flutter/material.dart';
import '../models/server_model.dart';
import '../services/api_service.dart';

class ServerProvider extends ChangeNotifier {
  List<ServerModel> _servers = [];
  List<ServerModel> _filteredServers = [];
  String _searchQuery = '';
  String _currentFilter = 'all';
  bool _isLoading = false;

  List<ServerModel> get servers =>
      _filteredServers.isEmpty ? _servers : _filteredServers;
  List<ServerModel> get allServers => _servers;
  String get currentFilter => _currentFilter;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> loadServers() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final servers = await _apiService.getServers();
      if (servers.isEmpty) {
        _servers = [
          ServerModel(
            id: 'fig-la1',
            country: 'USA',
            city: 'Los Angeles',
            countryCode: 'us',
            flag: 'us',
            ping: 25,
            load: 15,
            ip: '104.28.12.34',
            isFavorite: false,
            isRecommended: true,
            region: 'americas',
            maxSpeed: 1000,
            uptime: 99.9,
          ),
        ];
      } else {
        _servers = servers;
      }
      _applyFilters();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setFilter(String filter) {
    _currentFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void toggleFavorite(String serverId) {
    final index = _servers.indexWhere((s) => s.id == serverId);
    if (index != -1) {
      _servers[index] = _servers[index].copyWith(
        isFavorite: !_servers[index].isFavorite,
      );
      _applyFilters();
      notifyListeners();
    }
  }

  void _applyFilters() {
    var filtered = List<ServerModel>.from(_servers);

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((server) =>
              server.country
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              server.city.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply filter
    switch (_currentFilter) {
      case 'recommended':
        filtered = filtered.where((s) => s.ping < 100 && s.load < 50).toList();
        break;
      case 'fastest':
        filtered.sort((a, b) => a.ping.compareTo(b.ping));
        filtered = filtered.take(5).toList();
        break;
      case 'favorites':
        filtered = filtered.where((s) => s.isFavorite).toList();
        break;
      case 'europe':
        filtered = filtered
            .where((s) => ['Germany', 'UK', 'France'].contains(s.country))
            .toList();
        break;
      case 'asia':
        filtered = filtered
            .where((s) => ['Japan', 'Singapore', 'India'].contains(s.country))
            .toList();
        break;
      case 'americas':
        filtered = filtered
            .where((s) => ['USA', 'Canada', 'Brazil'].contains(s.country))
            .toList();
        break;
      default:
        break;
    }

    _filteredServers = filtered;
  }

  List<ServerModel> getPopularServers() {
    return _servers.take(4).toList();
  }

  List<ServerModel> getFilteredServers(String filter, String query) {
    var filtered = List<ServerModel>.from(_servers);
    
    // Apply search
    if (query.isNotEmpty) {
      filtered = filtered.where((server) =>
        server.country.toLowerCase().contains(query.toLowerCase()) ||
        server.city.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    
    // Apply filter
    switch (filter) {
      case 'recommended':
        filtered = filtered.where((s) => s.ping < 100 && s.load < 50).toList();
        break;
      case 'fastest':
        filtered.sort((a, b) => a.ping.compareTo(b.ping));
        filtered = filtered.take(5).toList();
        break;
      case 'favorites':
        filtered = filtered.where((s) => s.isFavorite).toList();
        break;
      case 'europe':
        filtered = filtered.where((s) => 
          ['Germany', 'UK', 'France'].contains(s.country)).toList();
        break;
      case 'asia':
        filtered = filtered.where((s) => 
          ['Japan', 'Singapore', 'India'].contains(s.country)).toList();
        break;
      case 'americas':
        filtered = filtered.where((s) => 
          ['USA', 'Canada', 'Brazil'].contains(s.country)).toList();
        break;
    }
    
    return filtered;
  }

  void resetFilters() {
    _searchQuery = '';
    _currentFilter = 'all';
    _filteredServers.clear();
    notifyListeners();
  }

}
