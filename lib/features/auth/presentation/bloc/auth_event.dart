part of 'auth_bloc.dart';

abstract class AuthEventBloc extends Equatable {
  const AuthEventBloc();
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEventBloc {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SaveAccessTokenEvent extends AuthEventBloc {
  final String token;

  const SaveAccessTokenEvent(this.token);

  @override
  List<Object> get props => [token];
}
