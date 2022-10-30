import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

import '../response.dart';

part 'get_video_response.g.dart';

@JsonSerializable()
class GetVideoResponse extends Response<VideoSchema> {
  GetVideoResponse(String code, String message, VideoSchema data) : super(code: code, message: message, data: data);
  factory GetVideoResponse.fromJson(Map<String, dynamic> json) => _$GetVideoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetVideoResponseToJson(this);
}