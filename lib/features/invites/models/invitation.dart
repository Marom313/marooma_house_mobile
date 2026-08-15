class Invitation {
  final String id;
  final String senderId;
  final String senderName;
  final String senderEmail;
  final String? recipientEmail;
  final String referralCode;
  final DateTime createdAt;
  final String status; // pending, accepted, expired
  final DateTime? acceptedAt;
  final int referralReward; // discount percentage

  Invitation({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    this.recipientEmail,
    required this.referralCode,
    required this.createdAt,
    required this.status,
    this.acceptedAt,
    required this.referralReward,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderEmail: json['senderEmail'] as String,
      recipientEmail: json['recipientEmail'] as String?,
      referralCode: json['referralCode'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
      acceptedAt:
          json['acceptedAt'] != null ? DateTime.parse(json['acceptedAt'] as String) : null,
      referralReward: json['referralReward'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'senderName': senderName,
    'senderEmail': senderEmail,
    'recipientEmail': recipientEmail,
    'referralCode': referralCode,
    'createdAt': createdAt.toIso8601String(),
    'status': status,
    'acceptedAt': acceptedAt?.toIso8601String(),
    'referralReward': referralReward,
  };
}
