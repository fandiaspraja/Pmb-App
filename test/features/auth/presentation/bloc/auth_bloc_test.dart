import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:pmb_app/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';
import 'package:pmb_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:pmb_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthUsecase, SharedPreferencesHelper])
void main() {
  late AuthBloc authBloc;
  late MockAuthUsecase mockAuthUsecase;
  late MockSharedPreferencesHelper mockSharedPreferencesHelper;

  setUp(() {
    mockAuthUsecase = MockAuthUsecase();
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();

    authBloc = AuthBloc(mockAuthUsecase, mockSharedPreferencesHelper);
  });

  // =====================================================
  // TEST DATA
  // =====================================================

  const tEmail = "test@mail.com";
  const tPassword = "123456";
  const tToken = "access_token_123";

  final tLoginRequest = LoginRequest(email: tEmail, password: tPassword);

  final tUser = UserEntity(
    id: 1,
    name: "Test User",
    email: tEmail,
    token: tToken,
  );

  group("AuthBloc", () {
    // =====================================================
    // INITIAL STATE
    // =====================================================

    test("initial state should be AuthLoading", () {
      expect(authBloc.state, AuthLoading());
    });

    // =====================================================
    // LOGIN SUCCESS
    // =====================================================

    blocTest<AuthBloc, AuthStateBloc>(
      "should emit [AuthLoading, LoginSuccess] when login success",
      build: () {
        when(mockAuthUsecase.login(any)).thenAnswer((_) async => Right(tUser));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const LoginEvent(email: tEmail, password: tPassword));
      },
      expect: () => [AuthLoading(), LoginSuccess(tUser)],
      verify: (_) {
        verify(mockAuthUsecase.login(any)).called(1);
      },
    );

    // =====================================================
    // LOGIN FAILED
    // =====================================================

    blocTest<AuthBloc, AuthStateBloc>(
      "should emit [AuthLoading, AuthError] when login failed",
      build: () {
        when(
          mockAuthUsecase.login(any),
        ).thenAnswer((_) async => Left(ServerFailure("Invalid credential")));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const LoginEvent(email: tEmail, password: tPassword));
      },
      expect: () => [AuthLoading(), AuthError("Invalid credential")],
      verify: (_) {
        verify(mockAuthUsecase.login(any)).called(1);
      },
    );

    // =====================================================
    // SAVE TOKEN SUCCESS
    // =====================================================

    blocTest<AuthBloc, AuthStateBloc>(
      "should save access token successfully",
      build: () {
        when(
          mockSharedPreferencesHelper.saveUserToken(tToken),
        ).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const SaveAccessTokenEvent(tToken));
      },
      expect: () => [],
      verify: (_) {
        verify(mockSharedPreferencesHelper.saveUserToken(tToken)).called(1);
      },
    );

    // =====================================================
    // SAVE TOKEN FAILED
    // =====================================================

    blocTest<AuthBloc, AuthStateBloc>(
      "should emit AuthError when save token throws exception",
      build: () {
        when(
          mockSharedPreferencesHelper.saveUserToken(tToken),
        ).thenThrow(Exception("Save failed"));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const SaveAccessTokenEvent(tToken));
      },
      expect: () => [isA<AuthError>()],
    );
  });
}
