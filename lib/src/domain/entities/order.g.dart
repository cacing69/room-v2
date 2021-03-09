// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['order_id'] as int,
    no: json['order_no'] as String,
    status: json['order_status'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'order_id': instance.id,
      'order_no': instance.no,
      'order_status': instance.status,
    };
