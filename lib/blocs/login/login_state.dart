import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}
class LoginUninitialized extends LoginState {}

class LoginAuthenticated extends LoginState {
  final String token;

  LoginAuthenticated({required this.token});

  @override
  List<Object> get props => [token];
}

class LoginUnauthenticated extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
