class OrderRequestParams {
  final String status;
  final String q;
  final BigInt pelangganId;
  final String mode;
  final int limit;
  final int page;

  const OrderRequestParams({
    this.status,
    this.q,
    this.pelangganId,
    this.mode,
    this.limit = 10,
    this.page = 1,
  });

  OrderRequestParams copyWith({
    String status,
    String q,
    BigInt pelangganId,
    String mode,
    int limit,
    int page,
  }) {
    return OrderRequestParams(
      status: status ?? this.status,
      q: q ?? this.q,
      pelangganId: pelangganId ?? this.pelangganId,
      mode: mode ?? this.mode,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  OrderRequestParams copyWithQueryNull({
    String status,
    String q,
    BigInt pelangganId,
    String mode,
    int limit,
    int page,
  }) {
    return OrderRequestParams(
      status: status ?? this.status,
      q: null,
      pelangganId: pelangganId ?? this.pelangganId,
      mode: mode ?? this.mode,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }
}
