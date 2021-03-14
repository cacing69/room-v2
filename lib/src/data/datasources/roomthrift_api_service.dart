import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:room_v2/src/core/utils/constants.dart';
import 'package:room_v2/src/modules/order/models/order_list_response.dart';

part 'roomthrift_api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RoomthriftApiService {
  factory RoomthriftApiService(Dio dio, {String baseUrl}) =
      _RoomthriftApiService;

  @GET("/order")
  Future<HttpResponse<OrderListResponse>> getOrder({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('q') String q,
    @Query('order_by') String orderBy,
  });
}
