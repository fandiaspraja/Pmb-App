import 'package:dartz/dartz.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';
import 'package:pmb_app/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repository;

  AuthUsecase({required this.repository});

  Future<Either<Failure, UserEntity>> login(LoginRequest request) {
    return repository.login(request);
  }
}
