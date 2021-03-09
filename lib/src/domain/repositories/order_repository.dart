import 'package:room_v2/src/core/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:room_v2/src/data/models/order_list_response.dart';
import 'package:room_v2/src/domain/entities/order.dart';

abstract class OrderRepository {
  Future<DataState<OrderListResponse>> getOrders(OrderRequestParams params);
}
