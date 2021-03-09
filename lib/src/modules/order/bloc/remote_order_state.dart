part of 'remote_order_bloc.dart';

class RemoteOrderState extends Equatable {
  final List<Order> data;
  final bool hasNext;
  final DioError error;
  final bool isFirst;
  final bool isLoading;
  final int page;

  const RemoteOrderState({
    this.data,
    this.hasNext,
    this.error,
    this.page = 1,
    this.isFirst = true,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [data, hasNext, error, isFirst, isLoading, page];

  // @override
  // bool get stringify => true;

  RemoteOrderState copyWith({
    List<Order> data,
    bool hasNext,
    DioError error,
    bool isFirst,
    bool isLoading,
    int page,
  }) {
    return RemoteOrderState(
      data: data ?? this.data,
      hasNext: hasNext ?? this.hasNext,
      error: error ?? this.error,
      isFirst: isFirst ?? this.isFirst,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
    );
  }
}
