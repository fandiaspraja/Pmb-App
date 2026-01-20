import 'package:dio/dio.dart';
import 'package:pmb_app/core/network/api_client.dart';
import 'package:pmb_app/core/utils/exception.dart';
import 'package:pmb_app/core/utils/response_wrapper.dart';
import 'package:pmb_app/features/student/data/datasources/remote/student_remote_data_source.dart';
import 'package:pmb_app/features/student/data/models/major_response.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/data/models/student_response.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final ApiClient apiClient;

  StudentRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<StudentEntity> registerStudent(RegisterRequest request) async {
    try {
      final response = await apiClient.post(
        '/students',
        data: request.toJson(),
      );

      var converted = WrappedResponse<StudentResponse>.fromJson(
        response.data,
        (data) => StudentResponse.fromJson(data),
      );
      if (converted.status == true) {
        return StudentEntity.toEntity(converted.data!);
      } else {
        throw BaseException(message: converted.message);
      }
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<List<MajorEntity>> getMajors() async {
    try {
      final response = await apiClient.get('/majors');

      var converted = WrappedListResponse<MajorResponse>.fromjson(
        response.data,
        (data) {
          List<MajorResponse> majors = data
              .map((e) => MajorResponse.fromJson(e))
              .toList();
          return majors;
        },
      );
      if (converted.data != null) {
        return _mapMajorsToEntities(converted.data!);
      } else {
        throw BaseException(message: "No data found");
      }
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  List<MajorEntity> _mapMajorsToEntities(List<MajorResponse> majors) {
    List<MajorEntity> temps = majors.map((element) {
      var entity = MajorEntity.toEntity(element);
      return entity;
    }).toList();

    return temps;
  }

  @override
  Future<StudentEntity> getStudentDetail(int id) async {
    try {
      final response = await apiClient.get('/students/$id');

      var converted = WrappedResponse<StudentResponse>.fromJson(
        response.data,
        (data) => StudentResponse.fromJson(data),
      );
      if (converted.status == true) {
        return StudentEntity.toEntity(converted.data!);
      } else {
        throw BaseException(message: converted.message);
      }
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<List<StudentEntity>> getStudents() async {
    try {
      final response = await apiClient.get('/students');

      var converted = WrappedListResponse<StudentResponse>.fromjson(
        response.data,
        (data) {
          List<StudentResponse> majors = data
              .map((e) => StudentResponse.fromJson(e))
              .toList();
          return majors;
        },
      );
      if (converted.data != null) {
        return _mapStudentsToEntities(converted.data!);
      } else {
        throw BaseException(message: "No data found");
      }
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  List<StudentEntity> _mapStudentsToEntities(List<StudentResponse> students) {
    List<StudentEntity> temps = students.map((element) {
      var entity = StudentEntity.toEntity(element);
      return entity;
    }).toList();

    return temps;
  }
}
