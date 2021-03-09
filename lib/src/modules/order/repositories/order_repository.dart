import 'package:room_v2/src/modules/order/models/order_list_response.dart';
import 'package:room_v2/src/modules/order/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';

abstract class OrderRepository {
  Future<DataState<OrderListResponse>> getOrders(OrderRequestParams params);
}
