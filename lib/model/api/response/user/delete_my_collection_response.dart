import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_my_collection_response.g.dart';

@JsonSerializable()
class DeleteMyCollectionResponse extends Response<String> {
  DeleteMyCollectionResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory DeleteMyCollectionResponse.fromJson(Map<String, dynamic> json) => _$DeleteMyCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteMyCollectionResponseToJson(this);
}