import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mptask/constants.dart';
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
      if (event.username!.isEmpty && event.password!.isEmpty) {
        emit(LoginUninitialized());
        emit(LoginFailure(error: Constants.enteryourcredentials));
        return;
      } else if (event.username!.isEmpty) {
        emit(LoginUninitialized());
        emit(LoginFailure(error:  Constants.enteryourusername));
        return;
      } else if (event.password!.isEmpty) {
        emit(LoginUninitialized());
        emit(LoginFailure(error: Constants.enteryourpassword));
        return;
      }
      emit(LoginLoading());
      try {
        bool isSuccess = await loginRepository.authenticate(
          username: event.username!,
          password: event.password!,
          isRemember: event.rememberMe!,
        );
        if (isSuccess) {
          final token = await loginRepository.getToken();
          emit(LoginAuthenticated(token: token!));
        } else {
          emit(LoginFailure(error: Constants.entervalidcredentials));
        }
      } catch (e) {
        emit(LoginFailure(error: Constants.unexpectederroroccurred));
      }
    });
  }
}
