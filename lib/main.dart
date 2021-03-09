import 'package:room_v2/src/core/utils/constants.dart';
import 'package:room_v2/src/domain/usecases/get_order_usecase.dart';
import 'package:room_v2/src/injector.dart';
import 'package:room_v2/src/modules/auth/cubit/auth_cubit.dart';
import 'package:room_v2/src/modules/home/screen/home_screen.dart';
import 'package:room_v2/src/modules/login/bloc/login_bloc.dart';
import 'package:room_v2/src/modules/login/screen/login_screen.dart';
import 'package:room_v2/src/presentation/blocs/remote_order/remote_order_bloc.dart';
import 'package:room_v2/src/presentation/router/app_router.dart';
import 'package:room_v2/src/utilities/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  Bloc.observer = AppBlocObserver();

  await initializeDependencies();

  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({Key key, @required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<RemoteOrderBloc>(
            create: (_) => injector()..add(RemoteOrderFetched())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: APP_TITLE,
        onGenerateRoute: router.onGenerateRoute,
        home: _getHome(),
      ),
    );
  }

  Widget _getHome() {
    return Builder(builder: (context) {
      final stateAuth = context.watch<AuthCubit>().state?.isAuthenticated;

      Widget _home = LoginScreen();

      if (stateAuth) {
        _home = HomeScreen();
      }

      return _home;
    });
  }
}
