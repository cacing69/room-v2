import 'dart:io';

import 'package:room_v2/src/data/datasources/roomthrift_api_service.dart';
import 'package:room_v2/src/modules/order/models/order_list_response.dart';
import 'package:room_v2/src/modules/order/params/order_request_params.dart';
import 'package:room_v2/src/core/resources/data_state.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  final RoomthriftApiService roomthriftApiService;

  const OrderRepository(this.roomthriftApiService);

  Future<DataState<OrderListResponse>> getOrders(
      OrderRequestParams params) async {
    try {
      final httpResponse = await roomthriftApiService.getOrder(
          page: params.page, limit: 20, q: params.q, orderBy: params.orderBy);

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
