import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:room_v2/src/data/models/order_list_response.dart';
import 'package:room_v2/src/core/utils/constants.dart';

part 'roomthrift_api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RoomthriftApiService {
  factory RoomthriftApiService(Dio dio, {String baseUrl}) =
      _RoomthriftApiService;

  @GET("/order")
  Future<HttpResponse<OrderListResponse>> getOrder({
    @Query('page') int page,
    @Query('limit') int limit,
  });
}
