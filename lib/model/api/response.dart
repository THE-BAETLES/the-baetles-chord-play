import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Response<T> {
  String code;
  String message;
  T? data;
  Response({required this.code, required this.message, this.data});
}