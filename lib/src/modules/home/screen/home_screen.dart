import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_v2/src/modules/auth/cubit/auth_cubit.dart';
import 'package:room_v2/src/modules/login/bloc/login_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: _buildBody(buildContext),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("HOME"),
          ElevatedButton(
              key: Key('home_screen_logout_elevated_button'),
              child: Text('Logout'),
              onPressed: () {
                print("home_screen_logout_elevated_button::clicked");
                context.read<AuthCubit>().unAuthenticated();
                context.read<LoginBloc>().add(LoginReInitialize());
              }),
          ElevatedButton(
              key: Key('order_screen_setting_elevated_button'),
              child: Text('Order'),
              onPressed: () {
                Navigator.pushNamed(context, "/order");
              }),
          ElevatedButton(
              key: Key('home_screen_setting_elevated_button'),
              child: Text('Setting'),
              onPressed: () {
                Navigator.pushNamed(context, "/setting");
              })
        ],
      ),
    ));
  }
}
