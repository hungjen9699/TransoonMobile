class PaymentDTO {
  final int paymentId;
  final int credit;
  final String createdDate;
  final String paymentType;
  final String receiverId;
  final String senderId;

  PaymentDTO(this.paymentId, this.credit, this.createdDate, this.paymentType,
      this.receiverId, this.senderId);
  PaymentDTO._(
      {this.paymentId,
      this.credit,
      this.createdDate,
      this.paymentType,
      this.receiverId,
      this.senderId});
  factory PaymentDTO.fromJson(Map<String, dynamic> json) {
    return new PaymentDTO._(
      paymentId: json['paymentId'],
      credit: json['credit'],
      createdDate: json['createdDate'],
      paymentType: json['paymentType'],
      receiverId: json['receiverId'],
      senderId: json['senderId'],
    );
  }
}
