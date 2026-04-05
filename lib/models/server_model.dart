class ServerModel {
  final String id;
  final String country;
  final String city;
  final String countryCode;
  final String flag;
  final int ping;
  final int load;
  final String ip;
  final bool isFavorite;
  final bool isRecommended;
  final String region;
  final int maxSpeed;
  final double uptime;

  ServerModel({
    required this.id,
    required this.country,
    required this.city,
    required this.countryCode,
    required this.flag,
    required this.ping,
    required this.load,
    required this.ip,
    required this.isFavorite,
    this.isRecommended = false,
    required this.region,
    this.maxSpeed = 1000,
    this.uptime = 99.9,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      id: json['id'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      countryCode: json['countryCode'] ?? '',
      flag: json['flag'] ?? '',
      ping: json['ping'] ?? 0,
      load: json['load'] ?? 0,
      ip: json['ip'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      isRecommended: json['isRecommended'] ?? false,
      region: json['region'] ?? 'other',
      maxSpeed: json['maxSpeed'] ?? 1000,
      uptime: (json['uptime'] ?? 99.9).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'countryCode': countryCode,
      'flag': flag,
      'ping': ping,
      'load': load,
      'ip': ip,
      'isFavorite': isFavorite,
      'isRecommended': isRecommended,
      'region': region,
      'maxSpeed': maxSpeed,
      'uptime': uptime,
    };
  }

  ServerModel copyWith({
    String? id,
    String? country,
    String? city,
    String? countryCode,
    String? flag,
    int? ping,
    int? load,
    String? ip,
    bool? isFavorite,
    bool? isRecommended,
    String? region,
    int? maxSpeed,
    double? uptime,
  }) {
    return ServerModel(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      ping: ping ?? this.ping,
      load: load ?? this.load,
      ip: ip ?? this.ip,
      isFavorite: isFavorite ?? this.isFavorite,
      isRecommended: isRecommended ?? this.isRecommended,
      region: region ?? this.region,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      uptime: uptime ?? this.uptime,
    );
  }

  String get displayName => '$city, $country';
  String get loadPercentage => '$load%';
  String get pingMs => '$ping ms';
}