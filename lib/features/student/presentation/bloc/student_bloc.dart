import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pmb_app/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/domain/usecase/student_usecase.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEventBloc, StudentStateBloc> {
  final StudentUsecase usecase;
  final SharedPreferencesHelper sharedPreferencesHelper;

  StudentBloc(this.usecase, this.sharedPreferencesHelper)
    : super(MajorLoading()) {
    on<MajorsEvent>((event, emit) async {
      emit(MajorLoading());

      final result = await usecase.getMajors();
      result.fold(
        (failure) {
          emit(MajorError(failure.message));
        },
        (data) {
          emit(MajorSuccess(data));
        },
      );
    });

    on<StudentsEvent>((event, emit) async {
      emit(StudentListLoading());

      final result = await usecase.getStudents();
      result.fold(
        (failure) {
          emit(StudentListError(failure.message));
        },
        (data) {
          emit(StudentListSuccess(data));
        },
      );
    });

    on<RegisterStudentEvent>((event, emit) async {
      emit(StudentRegisterLoading());

      final result = await usecase.registerStudent(event.request);
      result.fold(
        (failure) {
          emit(StudentRegisterError(failure.message));
        },
        (data) {
          emit(StudentRegisterSuccess(data));
        },
      );
    });

    on<DetailStudentEvent>((event, emit) async {
      emit(StudentLoading());

      final result = await usecase.getStudentDetail(event.id);
      result.fold(
        (failure) {
          emit(StudentError(failure.message));
        },
        (data) {
          emit(StudentSuccess(data));
        },
      );
    });

    on<LogoutEvent>((event, emit) async {
      await sharedPreferencesHelper.removeUserData(); // Default ke 'en'
      emit(LogoutSuccess());
    });
  }
}
