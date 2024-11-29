import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {}

class UserSelected extends UserEvent {
  final int userId;

  UserSelected(this.userId);

  @override
  List<Object> get props => [userId];
}
