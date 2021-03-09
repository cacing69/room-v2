import 'package:flutter/material.dart';
import 'package:room_v2/src/modules/home/screen/home_screen.dart';
import 'package:room_v2/src/modules/login/screen/login_screen.dart';
import 'package:room_v2/src/modules/setting/screen/setting_screen.dart';
import 'package:room_v2/src/presentation/views/order_view.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case "/setting":
        return MaterialPageRoute(builder: (_) => SettingScreen());
        break;
      case "/order":
        return MaterialPageRoute(builder: (_) => OrderView());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body:
                      Center(child: Text('No route defined for ${route.name}')),
                ));
    }
  }
}
