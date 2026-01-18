import 'package:dartz/dartz.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/domain/repository/student_repository.dart';

class StudentUsecase {
  final StudentRepository repository;

  StudentUsecase({required this.repository});

  Future<Either<Failure, StudentEntity>> registerStudent(
    RegisterRequest request,
  ) {
    return repository.registerStudent(request);
  }

  Future<Either<Failure, List<MajorEntity>>> getMajors() {
    return repository.getMajors();
  }

  Future<Either<Failure, List<StudentEntity>>> getStudents() {
    return repository.getStudents();
  }

  Future<Either<Failure, StudentEntity>> getStudentDetail(int id) {
    return repository.getStudentDetail(id);
  }
}
