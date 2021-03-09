import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/modules/order/models/order.dart';
import 'package:room_v2/src/modules/order/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:room_v2/src/modules/order/repositories/order_repository.dart';

part 'remote_order_event.dart';
part 'remote_order_state.dart';

class RemoteOrderBloc
    extends BlocWithState<RemoteOrderEvent, RemoteOrderState> {
  final OrderRepository _orderRepository;

  RemoteOrderBloc(this._orderRepository) : super(RemoteOrderState());

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
      final dataState = await _orderRepository
          .getOrders(OrderRequestParams(limit: 20, page: _page));

      if (dataState is DataSuccess && dataState.data.data.isNotEmpty) {
        List<Order> orders = dataState.data.data;
        final noMoreData = dataState.data.total <= orders.length;

        _orders.addAll(orders);

        _page++;

        yield state.copyWith(
            data: _orders,
            noMoredata: noMoreData,
            isFirst: false,
            isLoading: false);
      }

      if (dataState is DataFailed) {
        yield state.copyWith(error: dataState.error, isLoading: false);
      }
    });
  }
}
