part of 'remote_order_bloc.dart';

abstract class RemoteOrderEvent extends Equatable {
  const RemoteOrderEvent();

  @override
  List<Object> get props => [];
}

// class GetOrders extends RemoteOrderEvent {
//   const GetOrders();
// }

// class NextOrders extends RemoteOrderEvent {
//   const NextOrders();
// }

class RemoteOrderCalled extends RemoteOrderEvent {
  RemoteOrderCalled();
}

class RemoteOrderFetched extends RemoteOrderEvent {
  RemoteOrderFetched();
}

class RemoteOrderRefreshed extends RemoteOrderEvent {
  RemoteOrderRefreshed();
}

class RemoteOrderFailed extends RemoteOrderEvent {
  RemoteOrderFailed();
}
