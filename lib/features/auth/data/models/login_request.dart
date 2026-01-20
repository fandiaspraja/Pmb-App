class LoginRequest {
  final String? email;
  final String? password;

  LoginRequest({this.email, this.password});

  @override
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
