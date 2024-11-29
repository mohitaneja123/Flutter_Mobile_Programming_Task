import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mptask/blocs/login/login_state.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_event.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  final _authenticationBloc = LoginBloc();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _authenticationBloc.close();
    super.dispose();
  }

  void _onLoginPressed() {
    _authenticationBloc.add(
      LoginSubmitted(
        username: _usernameController.text,
        password: _passwordController.text,
        rememberMe: _rememberMe,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _authenticationBloc,
        listener: _handleLoginState,
        builder: (context, state) => _buildLoginForm(context, state),
      ),
    );
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else if (state is LoginFailure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.error)));
    }
  }

  Widget _buildLoginForm(BuildContext context, LoginState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username',
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                  borderRadius:
                  BorderRadius.circular(10),
                ),),
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password',
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
          ),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) => setState(() => _rememberMe = value ?? false),
              ),
              Text('Remember Me'),
            ],
          ),
          SizedBox(height: 20),
          state is LoginLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: _onLoginPressed,
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}

