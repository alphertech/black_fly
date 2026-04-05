class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String plan;
  final String memberSince;
  final String? avatarUrl;
  final bool isPremium;
  final int deviceCount;
  final int maxDevices;
  final double totalDataUsed;
  final double dataLimit;
  final DateTime? subscriptionExpiry;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.plan,
    required this.memberSince,
    this.avatarUrl,
    required this.isPremium,
    required this.deviceCount,
    required this.maxDevices,
    required this.totalDataUsed,
    required this.dataLimit,
    this.subscriptionExpiry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      plan: json['plan'] ?? 'Free',
      memberSince: json['memberSince'] ?? 'Jan 2025',
      avatarUrl: json['avatarUrl'],
      isPremium: json['isPremium'] ?? false,
      deviceCount: json['deviceCount'] ?? 0,
      maxDevices: json['maxDevices'] ?? 5,
      totalDataUsed: (json['totalDataUsed'] ?? 0).toDouble(),
      dataLimit: (json['dataLimit'] ?? 100).toDouble(),
      subscriptionExpiry: json['subscriptionExpiry'] != null
          ? DateTime.parse(json['subscriptionExpiry'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'plan': plan,
      'memberSince': memberSince,
      'avatarUrl': avatarUrl,
      'isPremium': isPremium,
      'deviceCount': deviceCount,
      'maxDevices': maxDevices,
      'totalDataUsed': totalDataUsed,
      'dataLimit': dataLimit,
      'subscriptionExpiry': subscriptionExpiry?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? plan,
    String? memberSince,
    String? avatarUrl,
    bool? isPremium,
    int? deviceCount,
    int? maxDevices,
    double? totalDataUsed,
    double? dataLimit,
    DateTime? subscriptionExpiry,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      plan: plan ?? this.plan,
      memberSince: memberSince ?? this.memberSince,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPremium: isPremium ?? this.isPremium,
      deviceCount: deviceCount ?? this.deviceCount,
      maxDevices: maxDevices ?? this.maxDevices,
      totalDataUsed: totalDataUsed ?? this.totalDataUsed,
      dataLimit: dataLimit ?? this.dataLimit,
      subscriptionExpiry: subscriptionExpiry ?? this.subscriptionExpiry,
    );
  }
}