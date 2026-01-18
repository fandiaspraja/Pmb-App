import 'package:pmb_app/features/auth/data/models/user_response.dart';

class UserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? token;

  UserEntity({this.id, this.name, this.email, this.token});

  factory UserEntity.toEntity(UserResponse response) {
    return UserEntity(
      token: response.token,
      id: response.id,
      name: response.name,
      email: response.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "token": token};
  }
}
