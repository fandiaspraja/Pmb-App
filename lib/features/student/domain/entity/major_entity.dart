import 'package:pmb_app/features/student/data/models/major_response.dart';

class MajorEntity {
  final int? id;
  final String? name;

  MajorEntity({this.id, this.name});

  factory MajorEntity.toEntity(MajorResponse response) {
    return MajorEntity(id: response.id, name: response.name);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
