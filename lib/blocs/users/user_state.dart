import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserFailure extends UserState {
  final String error;

  UserFailure(this.error);

  @override
  List<Object> get props => [error];
}
