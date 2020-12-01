class TransactionQueueDTO {
  final int transactionQueueId;
  final String transoonerId;
  final int transactionId;
  final String status;
  TransactionQueueDTO(this.transactionQueueId, this.transoonerId, this.status,
      this.transactionId);
  TransactionQueueDTO._(
      {this.transactionQueueId,
      this.transoonerId,
      this.status,
      this.transactionId});
  factory TransactionQueueDTO.fromJson(Map<String, dynamic> json) {
    return new TransactionQueueDTO._(
      transactionQueueId: json['transactionQueueId'],
      transoonerId: json['transoonerId'],
      transactionId: json['transactionId'],
      status: json['status'],
    );
  }
}
