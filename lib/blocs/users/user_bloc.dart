import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ApiService.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc({required this.apiService}) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await apiService.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserFailure('Failed to load users: $e'));
      }
    });
  }
}


