class NotificationDTO {
  final int pushNotificationId;
  final String customerId;
  final String transoonerId;
  final int transactionId;
  final String title;
  final String body;
  final String ownedBy;
  final String createdDate;
  NotificationDTO(
      this.pushNotificationId,
      this.customerId,
      this.transoonerId,
      this.transactionId,
      this.title,
      this.body,
      this.ownedBy,
      this.createdDate);
  NotificationDTO._({
    this.pushNotificationId,
    this.customerId,
    this.transoonerId,
    this.transactionId,
    this.title,
    this.body,
    this.ownedBy,
    this.createdDate,
  });
  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return new NotificationDTO._(
      pushNotificationId: json['pushNotificationId'],
      customerId: json['customerId'],
      transoonerId: json['transoonerId'],
      transactionId: json['transactionId'],
      title: json['title'],
      body: json['body'],
      ownedBy: json['ownedBy'],
      createdDate: json['createdDate'],
    );
  }
}
