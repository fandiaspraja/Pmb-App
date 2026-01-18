import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginRequest request);
}
