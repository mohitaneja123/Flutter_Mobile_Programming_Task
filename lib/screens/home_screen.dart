import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mptask/blocs/users/user_event.dart';
import 'package:mptask/constants.dart';
import 'package:mptask/screens/user_detail_screen.dart';
import '../blocs/users/user_bloc.dart';
import '../blocs/users/user_state.dart';
import '../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUsers());

    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return buildLoading();
          } else if (state is UserLoaded) {
            return buildUserList(context, state.users);
          } else if (state is UserFailure) {
            return buildError(state.error);
          } else {
            return buildNoUsers();
          }
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }
  Widget buildError(String error) {
    return Center(child: Text('Failed to load users: $error'));
  }
  Widget buildNoUsers() {
    return Center(child: const Text(Constants.nousersavaliable));
  }
  Widget buildUserList(BuildContext context, List<User> users) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(FetchUsers());
      },
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return buildUserTile(context, user);
        },
      ),
    );
  }

  Widget buildUserTile(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailScreen(user: user),
          ),
        );
      },
    );
  }
}
