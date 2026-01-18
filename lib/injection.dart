import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pmb_app/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:pmb_app/core/network/api_client.dart';
import 'package:pmb_app/core/network/network_info.dart';
import 'package:pmb_app/core/network/request_interceptor.dart';
import 'package:pmb_app/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:pmb_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:pmb_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pmb_app/features/auth/domain/repository/auth_repository.dart';
import 'package:pmb_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:pmb_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pmb_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:pmb_app/features/student/data/datasources/remote/student_remote_data_source.dart';
import 'package:pmb_app/features/student/data/datasources/student_remote_data_source_impl.dart';
import 'package:pmb_app/features/student/data/repositories/student_repository_impl.dart';
import 'package:pmb_app/features/student/domain/repository/student_repository.dart';
import 'package:pmb_app/features/student/domain/usecase/student_usecase.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Step 1: Register SharedPreferences (Async)
  locator.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  // ✅ Step 2: Register SharedPreferencesHelper (Waits for SharedPreferences)
  locator.registerSingletonWithDependencies<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(pref: locator<SharedPreferences>()),
    dependsOn: [SharedPreferences],
  );

  // ✅ Step 3: Register RequestInterceptor (Waits for SharedPreferencesHelper)
  locator.registerSingletonWithDependencies<RequestInterceptor>(
    () => RequestInterceptor(pref: locator<SharedPreferencesHelper>()),
    dependsOn: [SharedPreferencesHelper],
  );

  // ✅ Step 4: Other Core Dependencies
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(locator(), locator()),
  );
  locator.registerLazySingleton(() => NetworkInfo(Connectivity()));

  // ✅ Step 5: Bloc Dependencies
  locator.registerFactory(() => AuthBloc(locator(), locator()));

  locator.registerFactory(() => StudentBloc(locator(), locator()));

  locator.registerFactory(() => SplashBloc(locator()));

  // usecase

  locator.registerFactory(() => AuthUsecase(repository: locator()));
  locator.registerFactory(() => StudentUsecase(repository: locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(remoteDataSource: locator()),
  );

  // remote data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: locator()),
  );
  locator.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSourceImpl(apiClient: locator()),
  );

  // ✅ Step 9: Ensure All Dependencies Are Ready
  await locator.allReady();
}
