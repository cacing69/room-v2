import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/core/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:room_v2/src/domain/entities/order.dart';
import 'package:dio/dio.dart';
import 'package:room_v2/src/domain/usecases/get_order_usecase.dart';

part 'remote_order_event.dart';
part 'remote_order_state.dart';

class RemoteOrderBloc
    extends BlocWithState<RemoteOrderEvent, RemoteOrderState> {
  final GetOrderUseCase _getOrderUseCase;

  RemoteOrderBloc(this._getOrderUseCase) : super(RemoteOrderState());

  final List<Order> _orders = [];

  int _page = 1;

  static const int _pageSize = 20;

  @override
  Stream<RemoteOrderState> mapEventToState(
    RemoteOrderEvent event,
  ) async* {
    if (event is RemoteOrderFetched) {
      yield* _getOrders(event);
    }

    if (event is RemoteOrderLoading) {
      yield state.copyWith(isLoading: true);
    }
  }

  Stream<RemoteOrderState> _getOrders(RemoteOrderEvent event) async* {
    yield* runBlocProcess(() async* {
      final dataState = await _getOrderUseCase(
          params: OrderRequestParams(page: _page, limit: 20));

      if (dataState is DataSuccess && dataState.data.data.isNotEmpty) {
        List<Order> orders = dataState.data.data;
        final noMoreData = dataState.data.total <= orders.length;

        _orders.addAll(orders);

        _page++;

        // yield RemoteOrderDone(data: _orders, noMoredata: noMoreData);
        yield state.copyWith(
            data: _orders,
            noMoredata: noMoreData,
            isFirst: false,
            isLoading: false);
      }

      if (dataState is DataFailed) {
        yield state.copyWith(error: dataState.error);
      }
    });
  }
}