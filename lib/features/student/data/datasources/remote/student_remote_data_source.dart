import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';

abstract class StudentRemoteDataSource {
  Future<StudentEntity> registerStudent(RegisterRequest request);

  Future<List<MajorEntity>> getMajors();

  Future<List<StudentEntity>> getStudents();

  Future<StudentEntity> getStudentDetail(int id);
}
