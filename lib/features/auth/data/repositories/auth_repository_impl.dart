import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pmb_app/core/utils/exception.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';
import 'package:pmb_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(LoginRequest request) async {
    try {
      final result = await remoteDataSource.login(request);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on BaseException catch (e) {
      return Left(BaseFailure(e.message));
    }
  }
}
