import 'package:pmb_app/core/utils/serializable.dart';

class UserResponse implements Serializable {
  final int? id;
  final String? name;
  final String? email;
  final String? token;

  UserResponse({this.id, this.name, this.email, this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      token: json["token"],
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
