class RegisterRequest {
  final String? name;
  final String? nisn;
  final String? birtday;
  final String? major;

  RegisterRequest({this.name, this.nisn, this.birtday, this.major});

  @override
  Map<String, dynamic> toJson() {
    return {"name": name, "nisn": nisn, "birth_date": birtday, "major": major};
  }
}
