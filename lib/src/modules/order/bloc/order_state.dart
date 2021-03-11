part of 'order_bloc.dart';

class OrderState extends Equatable {
  final List<Order> data;
  final bool hasNext;
  final DioError error;
  final bool isFirst;
  final bool isError;
  final bool isLoading;
  final OrderRequestParams requestParams;

  const OrderState({
    this.data,
    this.hasNext = true,
    this.error,
    this.isFirst = true,
    this.isError = false,
    this.isLoading = true,
    this.requestParams = const OrderRequestParams(page: 1, limit: 20),
  });

  @override
  List<Object> get props {
    return [
      data,
      hasNext,
      error,
      isFirst,
      isError,
      isLoading,
      requestParams,
    ];
  }

  // @override
  // bool get stringify => true;

  OrderState copyWith({
    List<Order> data,
    bool hasNext,
    DioError error,
    bool isFirst,
    bool isError,
    bool isLoading,
    OrderRequestParams requestParams,
  }) {
    return OrderState(
      data: data ?? this.data,
      hasNext: hasNext ?? this.hasNext,
      error: error ?? this.error,
      isFirst: isFirst ?? this.isFirst,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      requestParams: requestParams ?? this.requestParams,
    );
  }
}
