import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

import '../response.dart';

part 'get_my_collection_response.g.dart';

@JsonSerializable()
class GetMyCollectionResponse extends Response<List<VideoSchema>> {
  GetMyCollectionResponse(String code, String message, List<VideoSchema> data) : super(code: code, message: message, data: data);
  factory GetMyCollectionResponse.fromJson(Map<String, dynamic> json) => _$GetMyCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyCollectionResponseToJson(this);
}