import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/authentication_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(LoginUninitialized()) {
    on<LoginStarted>((event, emit) async {
      final token = await loginRepository.getToken();
      final isremember = await loginRepository.isRemember();
      if (token != null) {
        if(isremember){
          emit(LoginAuthenticated(token: token));
        }else{
          emit(LoginUnauthenticated());
        }
      } else {
        emit(LoginUnauthenticated());
      }
    });

    on<LoginSubmitted>((event, emit) async {
      if (event.username.isEmpty) {
        emit(LoginUninitialized()); // Emit a temporary state
        emit(LoginFailure(error: "Please enter your username"));
        return;
      } else if (event.password.isEmpty) {
        emit(LoginUninitialized()); // Emit a temporary state
        emit(LoginFailure(error: "Please enter your password"));
        return;
      }
      emit(LoginLoading());
      try {
        bool isSuccess = await loginRepository.authenticate(
          username: event.username,
          password: event.password,
          isRemember: event.rememberMe,
        );
        if (isSuccess) {
          final token = await loginRepository.getToken();
          emit(LoginAuthenticated(token: token!));
        } else {
          emit(LoginFailure(error: "Please enter valid credentials"));
        }
      } catch (e) {
        emit(LoginFailure(error: "An unexpected error occurred"));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(LoginLoading());
      await loginRepository.clearToken();
      emit(LoginUnauthenticated());
    });
  }
}
