import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
// fieldRename: FieldRename.snake
// @JsonKey(defaultValue: false)
class Order extends Equatable {
  @JsonKey(name: "order_id")
  final int id;
  @JsonKey(name: "order_no")
  final String no;
  @JsonKey(name: "order_status")
  final String status;

  Order({
    this.id,
    this.no,
    this.status,
  });

  @override
  List<Object> get props => [id, no, status];

  @override
  bool get stringify => true;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'no': no,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      id: map['id'],
      no: map['no'],
      status: map['status'],
    );
  }
}
