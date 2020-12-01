class LoginDTO {
  final String jwtToken;
  final String userId;
  LoginDTO._({this.jwtToken, this.userId});
  factory LoginDTO.fromJson(Map<String, dynamic> json) {
    return new LoginDTO._(
      jwtToken: json['jwtToken'],
      userId: json['userId'],
    );
  }
}
