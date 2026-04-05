class ConnectionStats {
  final DateTime timestamp;
  final String serverId;
  final String serverName;
  final String ipAddress;
  final int durationSeconds;
  final double downloadedMB;
  final double uploadedMB;
  final double averageSpeed;

  ConnectionStats({
    required this.timestamp,
    required this.serverId,
    required this.serverName,
    required this.ipAddress,
    required this.durationSeconds,
    required this.downloadedMB,
    required this.uploadedMB,
    required this.averageSpeed,
  });

  factory ConnectionStats.fromJson(Map<String, dynamic> json) {
    return ConnectionStats(
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      serverId: json['serverId'] ?? '',
      serverName: json['serverName'] ?? '',
      ipAddress: json['ipAddress'] ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      downloadedMB: (json['downloadedMB'] ?? 0).toDouble(),
      uploadedMB: (json['uploadedMB'] ?? 0).toDouble(),
      averageSpeed: (json['averageSpeed'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'serverId': serverId,
      'serverName': serverName,
      'ipAddress': ipAddress,
      'durationSeconds': durationSeconds,
      'downloadedMB': downloadedMB,
      'uploadedMB': uploadedMB,
      'averageSpeed': averageSpeed,
    };
  }

  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  double get totalMB => downloadedMB + uploadedMB;
  String get formattedTotal => '${totalMB.toStringAsFixed(1)} MB';
}