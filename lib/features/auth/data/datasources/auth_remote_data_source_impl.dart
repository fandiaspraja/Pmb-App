import 'package:dio/dio.dart';
import 'package:pmb_app/core/network/api_client.dart';
import 'package:pmb_app/core/utils/exception.dart';
import 'package:pmb_app/core/utils/response_wrapper.dart';
import 'package:pmb_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/student/data/models/major_response.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/data/models/student_response.dart';
import 'package:pmb_app/features/auth/data/models/user_response.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserEntity> login(LoginRequest request) async {
    try {
      final response = await apiClient.post(
        '/auth/login',
        data: request.toJson(),
      );

      var converted = WrappedResponse<UserResponse>.fromJson(
        response.data,
        (data) => UserResponse.fromJson(data),
      );

      if (converted.status == true) {
        return UserEntity.toEntity(converted.data!);
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
      final response = await apiClient.get('/students');

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
}
