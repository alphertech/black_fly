class Constants {
  static const String appName = 'SEYTRONS';
  static const String appVersion = '2.4.1';
  
  // API
  static const String apiBaseUrl = 'http://localhost:5000/api';
  
  // Storage Keys
  static const String keyOnboardingComplete = 'onboardingComplete';
  static const String keyUserEmail = 'user_email';
  static const String keyDarkMode = 'darkMode';
  static const String keyLanguage = 'language';
  
  // VPN Settings
  static const List<String> protocols = ['WireGuard', 'OpenVPN', 'IKEv2'];
  static const int maxDevicesFree = 3;
  static const int maxDevicesPremium = 10;
  static const double freeDataLimit = 10; // GB
  static const double premiumDataLimit = 1000; // GB
  
  // Server Regions
  static const Map<String, String> regions = {
    'europe': 'Europe',
    'asia': 'Asia',
    'americas': 'Americas',
    'africa': 'Africa',
    'oceania': 'Oceania',
  };
}