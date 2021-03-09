import 'dart:io';

import 'package:room_v2/src/data/datasources/remote/roomthrift_api_service.dart';
import 'package:room_v2/src/core/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:room_v2/src/data/models/order_list_response.dart';
import 'package:room_v2/src/domain/entities/order.dart';
import 'package:room_v2/src/domain/repositories/order_repository.dart';
import 'package:dio/dio.dart';

class OrderRepositoryImpl implements OrderRepository {
  final RoomthriftApiService roomthriftApiService;

  const OrderRepositoryImpl(this.roomthriftApiService);

  @override
  Future<DataState<OrderListResponse>> getOrders(
      OrderRequestParams params) async {
    try {
      final httpResponse =
          await roomthriftApiService.getOrder(page: params.page, limit: 20);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      // DioError _cek = DioError
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          request: httpResponse.response.request,
          type: DioErrorType.RESPONSE,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}

void main() async {
  OrderRepositoryImpl api = OrderRepositoryImpl(RoomthriftApiService(Dio()));

  DataState test = await api.getOrders(OrderRequestParams(page: 1));
  print(test.data);
}
