import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pmb_app/core/utils/exception.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/student/data/datasources/remote/student_remote_data_source.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/domain/repository/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  StudentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, StudentEntity>> registerStudent(
    RegisterRequest request,
  ) async {
    try {
      final result = await remoteDataSource.registerStudent(request);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on BaseException catch (e) {
      return Left(BaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MajorEntity>>> getMajors() async {
    try {
      final result = await remoteDataSource.getMajors();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on BaseException catch (e) {
      return Left(BaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> getStudentDetail(int id) async {
    try {
      final result = await remoteDataSource.getStudentDetail(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on BaseException catch (e) {
      return Left(BaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudents() async {
    try {
      final result = await remoteDataSource.getStudents();
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
