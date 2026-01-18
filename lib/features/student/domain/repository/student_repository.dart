import 'package:dartz/dartz.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';

abstract class StudentRepository {
  Future<Either<Failure, StudentEntity>> registerStudent(
    RegisterRequest request,
  );

  Future<Either<Failure, List<MajorEntity>>> getMajors();

  Future<Either<Failure, List<StudentEntity>>> getStudents();

  Future<Either<Failure, StudentEntity>> getStudentDetail(int id);
}
