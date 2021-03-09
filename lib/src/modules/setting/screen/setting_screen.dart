import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_v2/src/modules/auth/cubit/auth_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("SETTING"),
              BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                return Text(
                    "AUTH_STATE:${context.watch<AuthCubit>().state.isAuthenticated}");
              })
            ],
          ),
        ),
      ),
    );
  }
}
