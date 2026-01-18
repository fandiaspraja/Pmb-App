import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmb_app/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:pmb_app/features/auth/data/models/login_request.dart';
import 'package:pmb_app/features/auth/domain/entity/user_entity.dart';
import 'package:pmb_app/features/auth/domain/usecase/auth_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEventBloc, AuthStateBloc> {
  final AuthUsecase authUsecase;
  final SharedPreferencesHelper sharedPreferencesHelper;

  AuthBloc(this.authUsecase, this.sharedPreferencesHelper)
    : super(AuthLoading()) {
    on<LoginEvent>((event, emit) async {
      final String email = event.email;
      final String password = event.password;
      LoginRequest request = LoginRequest(email: email, password: password);

      emit(AuthLoading());

      final result = await authUsecase.login(request);
      result.fold(
        (failure) {
          emit(AuthError(failure.message));
        },
        (data) {
          emit(LoginSuccess(data));
        },
      );
    });

    on<SaveAccessTokenEvent>((event, emit) async {
      final String token = event.token;

      try {
        final result = sharedPreferencesHelper.saveUserToken(token);
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });
  }
}
