import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:pmb_app/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:pmb_app/core/utils/failure.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/domain/usecase/student_usecase.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';

import 'student_bloc_test.mocks.dart';

@GenerateMocks([StudentUsecase, SharedPreferencesHelper])
void main() {
  late StudentBloc studentBloc;
  late MockStudentUsecase mockStudentUsecase;
  late MockSharedPreferencesHelper mockSharedPreferencesHelper;

  setUp(() {
    mockStudentUsecase = MockStudentUsecase();
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();

    studentBloc = StudentBloc(mockStudentUsecase, mockSharedPreferencesHelper);
  });

  // =====================================================
  // DUMMY DATA
  // =====================================================

  const tStudentId = 1;

  final tMajors = [
    MajorEntity(id: 1, name: 'IPA'),
    MajorEntity(id: 2, name: 'IPS'),
  ];

  final tStudents = [
    StudentEntity(id: 1, name: 'Andi', nisn: 'andi@mail.com', major: 'IPA'),
    StudentEntity(id: 2, name: 'Budi', nisn: 'budi@mail.com', major: 'IPS'),
  ];

  final tStudentDetail = StudentEntity(
    id: 1,
    name: 'Andi',
    nisn: 'andi@mail.com',
    major: 'IPA',
  );

  final tRegisterRequest = RegisterRequest(
    name: 'Andi',
    nisn: 'andi@mail.com',
    birtday: '2000-01-01',
    major: 'IPA',
  );

  group('StudentBloc', () {
    // =====================================================
    // INITIAL STATE
    // =====================================================

    test('initial state should be MajorLoading', () {
      expect(studentBloc.state, MajorLoading());
    });

    // =====================================================
    // GET MAJORS
    // =====================================================

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [MajorLoading, MajorSuccess] when get majors success',
      build: () {
        when(
          mockStudentUsecase.getMajors(),
        ).thenAnswer((_) async => Right(tMajors));
        return studentBloc;
      },
      act: (bloc) => bloc.add(MajorsEvent()),
      expect: () => [MajorLoading(), MajorSuccess(tMajors)],
      verify: (_) {
        verify(mockStudentUsecase.getMajors()).called(1);
      },
    );

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [MajorLoading, MajorError] when get majors failed',
      build: () {
        when(
          mockStudentUsecase.getMajors(),
        ).thenAnswer((_) async => Left(ServerFailure('Failed load majors')));
        return studentBloc;
      },
      act: (bloc) => bloc.add(MajorsEvent()),
      expect: () => [MajorLoading(), const MajorError('Failed load majors')],
    );

    // =====================================================
    // GET STUDENTS
    // =====================================================

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [StudentListLoading, StudentListSuccess] when get students success',
      build: () {
        when(
          mockStudentUsecase.getStudents(),
        ).thenAnswer((_) async => Right(tStudents));
        return studentBloc;
      },
      act: (bloc) => bloc.add(StudentsEvent()),
      expect: () => [StudentListLoading(), StudentListSuccess(tStudents)],
    );

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [StudentListLoading, StudentListError] when get students failed',
      build: () {
        when(
          mockStudentUsecase.getStudents(),
        ).thenAnswer((_) async => Left(ServerFailure('Failed load students')));
        return studentBloc;
      },
      act: (bloc) => bloc.add(StudentsEvent()),
      expect: () => [
        StudentListLoading(),
        const StudentListError('Failed load students'),
      ],
    );

    // =====================================================
    // REGISTER STUDENT
    // =====================================================

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [StudentRegisterLoading, StudentRegisterSuccess] when register success',
      build: () {
        when(
          mockStudentUsecase.registerStudent(any),
        ).thenAnswer((_) async => Right(tStudentDetail));
        return studentBloc;
      },
      act: (bloc) => bloc.add(RegisterStudentEvent(request: tRegisterRequest)),
      expect: () => [
        StudentRegisterLoading(),
        StudentRegisterSuccess(tStudentDetail),
      ],
    );

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [StudentRegisterLoading, StudentRegisterError] when register failed',
      build: () {
        when(
          mockStudentUsecase.registerStudent(any),
        ).thenAnswer((_) async => Left(ServerFailure('Register failed')));
        return studentBloc;
      },
      act: (bloc) => bloc.add(RegisterStudentEvent(request: tRegisterRequest)),
      expect: () => [
        StudentRegisterLoading(),
        const StudentRegisterError('Register failed'),
      ],
    );

    // =====================================================
    // DETAIL STUDENT
    // =====================================================

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [StudentLoading, StudentSuccess] when get detail success',
      build: () {
        when(
          mockStudentUsecase.getStudentDetail(tStudentId),
        ).thenAnswer((_) async => Right(tStudentDetail));
        return studentBloc;
      },
      act: (bloc) => bloc.add(const DetailStudentEvent(id: tStudentId)),
      expect: () => [StudentLoading(), StudentSuccess(tStudentDetail)],
    );

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [StudentLoading, StudentError] when get detail failed',
      build: () {
        when(
          mockStudentUsecase.getStudentDetail(tStudentId),
        ).thenAnswer((_) async => Left(ServerFailure('Student not found')));
        return studentBloc;
      },
      act: (bloc) => bloc.add(const DetailStudentEvent(id: tStudentId)),
      expect: () => [StudentLoading(), const StudentError('Student not found')],
    );

    // =====================================================
    // LOGOUT
    // =====================================================

    blocTest<StudentBloc, StudentStateBloc>(
      'emit [LogoutSuccess] when logout success',
      build: () {
        when(
          mockSharedPreferencesHelper.removeUserData(),
        ).thenAnswer((_) async => true);
        return studentBloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: () => [LogoutSuccess()],
      verify: (_) {
        verify(mockSharedPreferencesHelper.removeUserData()).called(1);
      },
    );
  });
}
