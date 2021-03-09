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
}
