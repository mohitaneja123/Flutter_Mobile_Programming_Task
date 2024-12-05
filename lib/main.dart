import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mptask/screens/splash_screen.dart';
import 'ApiService.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/users/user_bloc.dart';
import 'repositories/user_repository.dart'; // Import your UserRepository
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'repositories/login_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => LoginRepository()),
        RepositoryProvider(create: (_) => ApiService()), // Provide the UserRepository
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => UserBloc(
            apiService: RepositoryProvider.of<ApiService>(context),
            ),
          ),
        ],
        child: MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );
  }
}
