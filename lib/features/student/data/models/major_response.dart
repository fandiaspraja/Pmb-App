import 'package:pmb_app/core/utils/serializable.dart';

class MajorResponse implements Serializable {
  final int? id;
  final String? name;

  MajorResponse({this.id, this.name});

  factory MajorResponse.fromJson(Map<String, dynamic> json) {
    return MajorResponse(id: json["id"], name: json["name"]);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
