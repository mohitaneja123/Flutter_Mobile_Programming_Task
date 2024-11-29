import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginStarted extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;
  final bool rememberMe;

  LoginSubmitted({required this.username, required this.password,required this.rememberMe});

  @override
  List<Object> get props => [username, password,rememberMe];
}
class AutoLogin extends LoginEvent {}

class LogoutRequested extends LoginEvent {}
