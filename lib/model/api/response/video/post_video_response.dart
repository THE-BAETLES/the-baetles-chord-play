import 'package:json_annotation/json_annotation.dart';

import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';
import '../response.dart';

part 'post_video_response.g.dart';

@JsonSerializable()
class PostVideoResponse extends Response<VideoSchema> {
  PostVideoResponse(String code, String message, VideoSchema data) : super(code: code, message: message, data: data);
  factory PostVideoResponse.fromJson(Map<String, dynamic> json) => _$PostVideoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostVideoResponseToJson(this);
}


