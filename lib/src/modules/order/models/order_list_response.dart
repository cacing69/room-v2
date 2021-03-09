import 'package:json_annotation/json_annotation.dart';
import 'package:room_v2/src/modules/order/models/order.dart';
part 'order_list_response.g.dart';

@JsonSerializable()
class OrderListResponse {
  final bool status;

  @JsonKey(name: "order_no")
  final int currentPage;
  final int lastPage;

  final String firstPageUrl;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  final List<Order> data;

  OrderListResponse({
    this.status,
    this.currentPage,
    this.lastPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    this.data,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListResponseToJson(this);
}
