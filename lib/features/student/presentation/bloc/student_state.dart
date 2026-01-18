part of 'student_bloc.dart';

abstract class StudentStateBloc extends Equatable {
  const StudentStateBloc();
  @override
  List<Object> get props => [];
}

// all major state
class MajorLoading extends StudentStateBloc {}

class MajorEmpty extends StudentStateBloc {}

class MajorError extends StudentStateBloc {
  final String message;

  const MajorError(this.message);

  @override
  List<Object> get props => [message];
}

class MajorSuccess extends StudentStateBloc {
  final List<MajorEntity> majors;

  const MajorSuccess(this.majors);

  @override
  List<Object> get props => [majors];
}

// all student list state
class StudentListLoading extends StudentStateBloc {}

class StudentListEmpty extends StudentStateBloc {}

class StudentListError extends StudentStateBloc {
  final String message;

  const StudentListError(this.message);

  @override
  List<Object> get props => [message];
}

class StudentListSuccess extends StudentStateBloc {
  final List<StudentEntity> students;

  const StudentListSuccess(this.students);

  @override
  List<Object> get props => [students];
}

// all student detail state
class StudentLoading extends StudentStateBloc {}

class StudentEmpty extends StudentStateBloc {}

class StudentError extends StudentStateBloc {
  final String message;

  const StudentError(this.message);

  @override
  List<Object> get props => [message];
}

class StudentSuccess extends StudentStateBloc {
  final StudentEntity students;

  const StudentSuccess(this.students);

  @override
  List<Object> get props => [students];
}

// all register student state
class StudentRegisterLoading extends StudentStateBloc {}

class StudentRegisterEmpty extends StudentStateBloc {}

class StudentRegisterError extends StudentStateBloc {
  final String message;

  const StudentRegisterError(this.message);

  @override
  List<Object> get props => [message];
}

class StudentRegisterSuccess extends StudentStateBloc {
  final StudentEntity students;

  const StudentRegisterSuccess(this.students);

  @override
  List<Object> get props => [students];
}

class LogoutSuccess extends StudentStateBloc {}
