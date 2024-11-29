import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mptask/screens/splash_screen.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/users/user_bloc.dart';
import 'repositories/user_repository.dart'; // Import your UserRepository
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'repositories/authentication_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => LoginRepository()),
        RepositoryProvider(create: (_) => UserRepository()), // Provide the UserRepository
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => UserBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mobile Technical Interview',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
