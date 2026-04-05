import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/server_model.dart';
import '../utils/constants.dart';

class ApiService {
  final String baseUrl = Constants.apiBaseUrl;

  Future<List<ServerModel>> getServers() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Return mock servers
      return [
        ServerModel(
          id: 'ug-kp',
          country: 'Uganda',
          city: 'Kampala',
          countryCode: 'ug',
          flag: 'ug',
          ping: 24,
          load: 42,
          ip: '197.239.42.186',
          isFavorite: true,
          region: 'africa',
        ),
        ServerModel(
          id: 'us-ny',
          country: 'USA',
          city: 'New York',
          countryCode: 'us',
          flag: 'us',
          ping: 68,
          load: 78,
          ip: '198.51.100.42',
          isFavorite: false,
          region: 'americas',
        ),
        ServerModel(
          id: 'de-fr',
          country: 'Germany',
          city: 'Frankfurt',
          countryCode: 'de',
          flag: 'de',
          ping: 42,
          load: 35,
          ip: '203.0.113.17',
          isFavorite: false,
          region: 'europe',
        ),
        ServerModel(
          id: 'jp-tk',
          country: 'Japan',
          city: 'Tokyo',
          countryCode: 'jp',
          flag: 'jp',
          ping: 125,
          load: 56,
          ip: '192.0.2.84',
          isFavorite: true,
          region: 'asia',
        ),
        ServerModel(
          id: 'sg-sg',
          country: 'Singapore',
          city: 'Singapore',
          countryCode: 'sg',
          flag: 'sg',
          ping: 89,
          load: 23,
          ip: '198.51.100.93',
          isFavorite: false,
          region: 'asia',
        ),
        ServerModel(
          id: 'uk-ln',
          country: 'UK',
          city: 'London',
          countryCode: 'gb',
          flag: 'gb',
          ping: 52,
          load: 61,
          ip: '203.0.113.156',
          isFavorite: false,
          region: 'europe',
        ),
        ServerModel(
          id: 'ca-tr',
          country: 'Canada',
          city: 'Toronto',
          countryCode: 'ca',
          flag: 'ca',
          ping: 78,
          load: 44,
          ip: '192.0.2.231',
          isFavorite: false,
          region: 'americas',
        ),
        ServerModel(
          id: 'au-sy',
          country: 'Australia',
          city: 'Sydney',
          countryCode: 'au',
          flag: 'au',
          ping: 210,
          load: 31,
          ip: '198.51.100.12',
          isFavorite: false,
          region: 'oceania',
        ),
        ServerModel(
          id: 'br-sp',
          country: 'Brazil',
          city: 'Sao Paulo',
          countryCode: 'br',
          flag: 'br',
          ping: 185,
          load: 52,
          ip: '203.0.113.67',
          isFavorite: false,
          region: 'americas',
        ),
        ServerModel(
          id: 'in-mb',
          country: 'India',
          city: 'Mumbai',
          countryCode: 'in',
          flag: 'in',
          ping: 145,
          load: 47,
          ip: '192.0.2.45',
          isFavorite: false,
          region: 'asia',
        ),
      ];
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Connection failed'};
    }
  }
}