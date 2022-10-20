import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_my_collection_response.g.dart';

@JsonSerializable()
class PostMyCollectionResponse extends Response<String> {
  PostMyCollectionResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory PostMyCollectionResponse.fromJson(Map<String, dynamic> json) => _$PostMyCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostMyCollectionResponseToJson(this);
}
