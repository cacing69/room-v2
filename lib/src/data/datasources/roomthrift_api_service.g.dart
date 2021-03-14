// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomthrift_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RoomthriftApiService implements RoomthriftApiService {
  _RoomthriftApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://room.bitstudio.id/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<HttpResponse<OrderListResponse>> getOrder(
      {page, limit, q, orderBy}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'q': q,
      r'order_by': orderBy
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = OrderListResponse.fromJson(_result.data);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }
}
