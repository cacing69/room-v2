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

class RemoteOrderLoading extends RemoteOrderEvent {
  RemoteOrderLoading();
}

class RemoteOrderFetched extends RemoteOrderEvent {
  RemoteOrderFetched();
}

class RemoteOrderFaild extends RemoteOrderEvent {
  RemoteOrderFaild();
}
