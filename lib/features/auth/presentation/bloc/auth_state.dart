part of 'auth_bloc.dart';

abstract class AuthStateBloc extends Equatable {
  const AuthStateBloc();
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthStateBloc {}

class AuthEmpty extends AuthStateBloc {}

class AuthError extends AuthStateBloc {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginSuccess extends AuthStateBloc {
  final UserEntity userEntity;

  const LoginSuccess(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}
