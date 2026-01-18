import 'package:pmb_app/core/utils/serializable.dart';

class StudentResponse implements Serializable {
  final int? id;
  final String? name;
  final String? nisn;
  final String? birtdate;
  final String? major;

  StudentResponse({this.id, this.name, this.nisn, this.birtdate, this.major});

  factory StudentResponse.fromJson(Map<String, dynamic> json) {
    return StudentResponse(
      id: json["id"],
      name: json["name"],
      nisn: json["nisn"],
      birtdate: json["birth_date"],
      major: json["major"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
