import 'package:room_v2/src/modules/order/models/order_list_response.dart';
import 'package:room_v2/src/modules/order/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:room_v2/src/core/usecases/use_case.dart';
import 'package:room_v2/src/modules/order/repositories/order_repository.dart';

class GetOrderUseCase
    implements UseCase<DataState<OrderListResponse>, OrderRequestParams> {
  final OrderRepository _orderRepository;

  GetOrderUseCase(this._orderRepository);

  @override
  Future<DataState<OrderListResponse>> call({OrderRequestParams params}) {
    return _orderRepository.getOrders(params);
  }
}
