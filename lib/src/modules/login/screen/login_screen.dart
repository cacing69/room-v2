import 'package:room_v2/src/modules/auth/cubit/auth_cubit.dart';
import 'package:room_v2/src/modules/login/bloc/login_bloc.dart';
import 'package:room_v2/src/utilities/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess && state.success) {
              // if (state.success) {
              context.read<AuthCubit>().authenticated();
              // Navigator.pushReplacementNamed(context, "/home");
              // }
            }
          },
        ),
      ],
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  @override
  void initState() {
    // bool state = context.watch<AuthCubit>().state.isAuthenticated;
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              final username =
                  context.select((LoginBloc bloc) => bloc.state.username);

              return TextField(
                key: const Key('loginForm_usernameInput_textField'),
                onChanged: (value) => context
                    .read<LoginBloc>()
                    .add(LoginUsernameChanged(username: value)),
                decoration: InputDecoration(
                  labelText: 'username',
                  errorText: getValidator(username.error),
                ),
              );
            }),
            const Padding(padding: EdgeInsets.all(12)),
            Builder(builder: (context) {
              final password =
                  context.select((LoginBloc bloc) => bloc.state.password);

              return TextField(
                obscureText: true,
                key: const Key('loginForm_usernameInput_textField'),
                onChanged: (value) => context
                    .read<LoginBloc>()
                    .add(LoginPasswordChanged(password: value)),
                decoration: InputDecoration(
                  labelText: 'password',
                  errorText: getValidator(password.error),
                ),
              );
            }),
            const Padding(padding: EdgeInsets.all(12)),
            Builder(builder: (context) {
              final FormzStatus status =
                  context.select((LoginBloc bloc) => bloc.state.status);

              Widget _widget;

              if (status.isSubmissionInProgress) {
                _widget = CircularProgressIndicator();
              } else {
                Function _onPressed;

                if (status.isValidated) {
                  if (status.isValidated) {
                    _onPressed = () {
                      context.read<LoginBloc>().add(const LoginSubmitted());
                    };
                  }
                }

                _widget = ElevatedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    child: const Text('Login'),
                    onPressed: _onPressed);
              }

              return _widget;
            }),
            const Padding(padding: EdgeInsets.all(12)),
            ElevatedButton(
                key: Key('home_screen_setting_elevated_button'),
                child: Text('Setting'),
                onPressed: () {
                  Navigator.pushNamed(context, "/setting");
                })
          ],
        ),
      ),
    );
  }
}
