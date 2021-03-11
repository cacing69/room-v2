part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderCalled extends OrderEvent {
  OrderCalled();
}

class OrderFetched extends OrderEvent {
  OrderFetched();
}

class OrderRefreshed extends OrderEvent {
  OrderRefreshed();
}

class OrderFailed extends OrderEvent {
  OrderFailed();
}

class OrderReseted extends OrderEvent {
  OrderReseted();
}

class OrderSearchReseted extends OrderEvent {
  OrderSearchReseted();
}

class OrderSearched extends OrderEvent {
  final String query;
  OrderSearched(
    this.query,
  );
}
