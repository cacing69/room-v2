import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:room_v2/src/core/bloc/bloc_with_state.dart';
import 'package:room_v2/src/modules/order/models/order.dart';
import 'package:room_v2/src/modules/order/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:room_v2/src/modules/order/repositories/order_repository.dart';
// import 'package:rxdart/rxdart.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends BlocWithState<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc(this._orderRepository) : super(OrderState());

  final List<Order> _tmpData = [];
  // final BehaviorSubject _searching = BehaviorSubject<String>();

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is OrderCalled) {
      yield state.copyWith(isLoading: true);
    }

    if (event is OrderRefreshed) {
      _tmpData.clear();

      yield state.copyWith(
          isLoading: false,
          isFirst: true,
          data: List<Order>.empty(),
          error: DioError(),
          isError: false,
          requestParams: state.requestParams.copyWith(page: 1, limit: 20));
    }

    if (event is OrderFetched) {
      yield* _mapOrderFetchedToState(event, state);
    }

    if (event is OrderSearched) {
      yield state.copyWith(
          requestParams: state.requestParams.copyWith(q: event.query));
    }

    if (event is OrderSortByChanged) {
      yield state.copyWith(
          requestParams: state.requestParams.copyWith(orderBy: event.sortBy));
    }

    if (event is OrderReseted) {
      _tmpData.clear();
      yield state.copyWith(
          data: List.empty(),
          hasNext: true,
          isError: false,
          isLoading: true,
          requestParams: state.requestParams.copyWith(page: 1));
    }

    if (event is OrderSearchReseted) {
      yield state.copyWith(
          requestParams: state.requestParams.copyWithQueryNull());
    }
  }

  // @override
  // Stream<Transition<OrderEvent, OrderState>> transformEvents(
  //     Stream<OrderEvent> events, transitionFn) {
  //   return events
  //       .debounceTime(const Duration(milliseconds: 300))
  //       .switchMap((transitionFn));
  // }

  Stream<OrderState> _mapOrderFetchedToState(
      OrderEvent event, OrderState state) async* {
    yield* runBlocProcess(() async* {
      print("q:${state.requestParams.q}");

      final _responseState = await _orderRepository.getOrders(
          OrderRequestParams(
              limit: state.requestParams.limit,
              page: state.requestParams.page,
              q: state.requestParams.q));
      bool hasNext = true;
      if (_responseState is DataSuccess &&
          _responseState.data.data?.isNotEmpty) {
        List<Order> _dataResponse = _responseState.data.data;
        hasNext = _responseState.data.total > _tmpData.length;

        if (hasNext) {
          hasNext =
              _responseState.data.data.length == state.requestParams.limit;
        }

        _tmpData.addAll(_dataResponse);

        int _page = state.requestParams.page + 1;

        yield state.copyWith(
            data: _tmpData,
            hasNext: hasNext,
            isFirst: false,
            isLoading: false,
            isError: false,
            requestParams: state.requestParams.copyWith(page: _page));
      } else {
        yield state.copyWith(
            hasNext: false,
            isFirst: false,
            isLoading: false,
            isError: false,
            data: _tmpData);
      }

      if (_responseState is DataFailed) {
        yield state.copyWith(
            error: _responseState.error,
            isLoading: false,
            isError: true,
            data: _tmpData);
      }
    });
  }
}
