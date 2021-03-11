import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_v2/src/modules/auth/cubit/auth_cubit.dart';
import 'package:room_v2/src/modules/login/bloc/login_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
              child: Text('Logout'),
              onPressed: () {
                context.read<AuthCubit>().unAuthenticated();
                context.read<LoginBloc>().add(LoginReInitialize());
              }),
          ElevatedButton(
              child: Text('Order'),
              onPressed: () {
                Navigator.pushNamed(context, "/order");
              }),
          ElevatedButton(
              child: Text('Setting'),
              onPressed: () {
                Navigator.pushNamed(context, "/setting");
              }),
          ElevatedButton(
              child: Text('Success Info'),
              onPressed: () {
                BotToast.showNotification(
                  backgroundColor: Colors.green,
                  crossPage: false,
                  title: (_) => Text(
                    'Lorem ipsum',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: (_) => Text(
                    'Lorem ipsum dolor sit amet that graphics HAL is generating vsync timestamps using, that graphics HAL',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 3),
                  leading: (cancel) => SizedBox.fromSize(
                      size: const Size(40, 40),
                      child: IconButton(
                        icon:
                            Icon(EvaIcons.doneAllOutline, color: Colors.white),
                      )),
                );
              }),
          ElevatedButton(
              child: Text('Failed Info'),
              onPressed: () {
                BotToast.showNotification(
                  backgroundColor: Colors.red,
                  crossPage: false,
                  title: (_) => Text(
                    'Lorem ipsum',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: (_) => Text(
                    'Lorem ipsum dolor sit amet that graphics HAL is generating vsync timestamps using, that graphics HAL',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 3),
                  leading: (cancel) => SizedBox.fromSize(
                      size: const Size(40, 40),
                      child: IconButton(
                        icon: Icon(EvaIcons.closeCircleOutline,
                            color: Colors.white),
                      )),
                );
              }),
          ElevatedButton(
              child: Text('Blue Info'),
              onPressed: () {
                BotToast.showNotification(
                  backgroundColor: Colors.blue,
                  crossPage: false,
                  title: (_) => Text(
                    'Lorem ipsum',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: (_) => Text(
                    'Lorem ipsum dolor sit amet that graphics HAL is generating vsync timestamps using, that graphics HAL',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 3),
                  leading: (cancel) => SizedBox.fromSize(
                      size: const Size(40, 40),
                      child: IconButton(
                        icon: Icon(EvaIcons.infoOutline, color: Colors.white),
                      )),
                );
              }),
          ElevatedButton(
              child: Text('Warning Info'),
              onPressed: () {
                BotToast.showNotification(
                  backgroundColor: Colors.orange,
                  crossPage: false,
                  title: (_) => Text(
                    'Lorem ipsum',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: (_) => Text(
                    'Lorem ipsum dolor sit amet that graphics HAL is generating vsync timestamps using, that graphics HAL',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 3),
                  leading: (cancel) => SizedBox.fromSize(
                      size: const Size(40, 40),
                      child: IconButton(
                        icon: Icon(Icons.warning, color: Colors.white),
                      )),
                );
              })
        ],
      ),
    ));
  }
}
