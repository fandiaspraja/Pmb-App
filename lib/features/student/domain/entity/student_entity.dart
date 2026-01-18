import 'package:pmb_app/features/student/data/models/student_response.dart';
import 'package:pmb_app/features/auth/data/models/user_response.dart';

class StudentEntity {
  final int? id;
  final String? name;
  final String? nisn;
  final String? birtdate;
  final String? major;

  StudentEntity({this.id, this.name, this.nisn, this.birtdate, this.major});

  factory StudentEntity.toEntity(StudentResponse response) {
    return StudentEntity(
      id: response.id,
      name: response.name,
      nisn: response.nisn,
      birtdate: response.birtdate,
      major: response.major,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "nisn": nisn,
      "birtdate": birtdate,
      "major": major,
    };
  }
}
