part of 'remote_order_bloc.dart';

class RemoteOrderState extends Equatable {
  final List<Order> data;
  final bool noMoredata;
  final DioError error;
  final bool isFirst;
  final bool isLoading;

  const RemoteOrderState({
    this.data,
    this.noMoredata,
    this.error,
    this.isFirst = true,
    this.isLoading = true,
  });

  @override
  List<Object> get props => [data, noMoredata, error, isFirst, isLoading];

  @override
  bool get stringify => true;

  RemoteOrderState copyWith({
    List<Order> data,
    bool noMoredata,
    DioError error,
    bool isFirst,
    bool isLoading,
  }) {
    return RemoteOrderState(
      data: data ?? this.data,
      noMoredata: noMoredata ?? this.noMoredata,
      error: error ?? this.error,
      isFirst: isFirst ?? this.isFirst,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
