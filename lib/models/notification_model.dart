class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String icon;
  final DateTime timestamp;
  final bool isUnread;
  final String? actionUrl;
  final String type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.icon,
    required this.timestamp,
    required this.isUnread,
    this.actionUrl,
    this.type = 'info',
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      icon: json['icon'] ?? 'fa-info-circle',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isUnread: json['isUnread'] ?? true,
      actionUrl: json['actionUrl'],
      type: json['type'] ?? 'info',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'icon': icon,
      'timestamp': timestamp.toIso8601String(),
      'isUnread': isUnread,
      'actionUrl': actionUrl,
      'type': type,
    };
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? icon,
    DateTime? timestamp,
    bool? isUnread,
    String? actionUrl,
    String? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      icon: icon ?? this.icon,
      timestamp: timestamp ?? this.timestamp,
      isUnread: isUnread ?? this.isUnread,
      actionUrl: actionUrl ?? this.actionUrl,
      type: type ?? this.type,
    );
  }
}
