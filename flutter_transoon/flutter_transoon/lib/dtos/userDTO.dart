class UserDTO {
  final String userId;
  final String email;
  final String phoneNumber;
  final String fullName;
  final int balance;
  final String status;
  final String description;
  UserDTO._({
    this.userId,
    this.email,
    this.phoneNumber,
    this.fullName,
    this.balance,
    this.status,
    this.description,
  });
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return new UserDTO._(
      userId: json['userId'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      fullName: json['fullname'],
      balance: json['balance'],
      status: json['status'],
      description: json['description'],
    );
  }
}

class UserInfoUpdate {
  final String fullName;
  final String phoneNumber;
  UserInfoUpdate(this.fullName, this.phoneNumber);
  UserInfoUpdate._({
    this.fullName,
    this.phoneNumber,
  });
  factory UserInfoUpdate.fromJson(Map<String, dynamic> json) {
    return new UserInfoUpdate._(
      phoneNumber: json['phoneNumber'],
      fullName: json['fullname'],
    );
  }
}
