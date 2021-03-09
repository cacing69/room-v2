import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:room_v2/src/data/datasources/roomthrift_api_service.dart';
import 'package:room_v2/src/modules/order/bloc/remote_order_bloc.dart';
import 'package:room_v2/src/modules/order/repositories/order_repository_impl.dart';
import 'package:room_v2/src/modules/order/repositories/order_repository.dart';
import 'package:room_v2/src/modules/order/usecase/get_order_usecase.dart';

var injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio CLient
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<RoomthriftApiService>(
      RoomthriftApiService(injector()));

  injector.registerSingleton<OrderRepository>(OrderRepositoryImpl(injector()));

  //UseCases
  injector.registerSingleton<GetOrderUseCase>(GetOrderUseCase(injector()));

  // blocs
  injector.registerFactory<RemoteOrderBloc>(() => RemoteOrderBloc(injector()));
}
