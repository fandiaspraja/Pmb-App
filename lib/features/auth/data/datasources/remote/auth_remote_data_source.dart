import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(LoginRequest request);
}
