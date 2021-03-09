// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListResponse _$OrderListResponseFromJson(Map<String, dynamic> json) {
  return OrderListResponse(
    status: json['status'] as bool,
    currentPage: json['order_no'] as int,
    lastPage: json['lastPage'] as int,
    firstPageUrl: json['firstPageUrl'] as String,
    lastPageUrl: json['lastPageUrl'] as String,
    nextPageUrl: json['nextPageUrl'] as String,
    path: json['path'] as String,
    perPage: json['perPage'] as int,
    prevPageUrl: json['prevPageUrl'] as String,
    to: json['to'] as int,
    total: json['total'] as int,
    data: (json["data"] as List).map((i) => new Order.fromJson(i)).toList(),
  );
}

Map<String, dynamic> _$OrderListResponseToJson(OrderListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'order_no': instance.currentPage,
      'lastPage': instance.lastPage,
      'firstPageUrl': instance.firstPageUrl,
      'lastPageUrl': instance.lastPageUrl,
      'nextPageUrl': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prevPageUrl': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
      'data': instance.data,
    };
