part of 'student_bloc.dart';

abstract class StudentEventBloc extends Equatable {
  const StudentEventBloc();

  @override
  List<Object> get props => [];
}

class RegisterStudentEvent extends StudentEventBloc {
  final RegisterRequest request;
  const RegisterStudentEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class DetailStudentEvent extends StudentEventBloc {
  final int id;
  const DetailStudentEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class MajorsEvent extends StudentEventBloc {
  @override
  List<Object> get props => [];
}

class StudentsEvent extends StudentEventBloc {
  @override
  List<Object> get props => [];
}

class LogoutEvent extends StudentEventBloc {}
