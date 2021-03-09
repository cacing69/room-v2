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

  final List<Order> _tmpData = [];

  // int _page = 1;

  @override
  Stream<RemoteOrderState> mapEventToState(
    RemoteOrderEvent event,
  ) async* {
    if (event is RemoteOrderCalled) {
      yield state.copyWith(isLoading: true);
    } else if (event is RemoteOrderRefreshed) {
      _tmpData.clear();

      yield state.copyWith(
          isLoading: false,
          isFirst: true,
          data: List<Order>.empty(),
          error: null,
          page: 1);
    } else if (event is RemoteOrderFetched) {
      yield* _mapRemoteOrderFetchedToState(event, state);
    }
  }

  Stream<RemoteOrderState> _mapRemoteOrderFetchedToState(
      RemoteOrderEvent event, RemoteOrderState state) async* {
    yield* runBlocProcess(() async* {
      final _responseState = await _orderRepository
          .getOrders(OrderRequestParams(limit: 20, page: state.page));
      bool hasNext = true;
      if (_responseState is DataSuccess &&
          _responseState.data.data.isNotEmpty) {
        List<Order> _dataResponse = _responseState.data.data;
        hasNext = _responseState.data.total != _dataResponse.length;

        // List<Order> _blocOrderState = state.data;

        _tmpData.addAll(_dataResponse);

        print("page:" + state.page.toString());
        print("length:" + _tmpData.length.toString());

        int _page = state.page + 1;

        yield state.copyWith(
            data: _tmpData,
            hasNext: hasNext,
            isFirst: false,
            isLoading: false,
            page: _page);
      } else {
        hasNext = _responseState.data.total != state.data.length;
        yield state.copyWith(hasNext: false, isFirst: false, isLoading: false);
      }

      if (_responseState is DataFailed) {
        yield state.copyWith(error: _responseState.error, isLoading: false);
      }
    });
  }
}
