
import 'package:json_annotation/json_annotation.dart';

import '../../../schema/video/video_schema.dart';
import '../request.dart';

part 'post_video_request.g.dart';

@JsonSerializable()
class PostVideoRequest extends Request {
  VideoSchema video;

  PostVideoRequest({required this.video});

  factory PostVideoRequest.fromJson(Map<String, dynamic> json) => _$PostVideoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostVideoRequestToJson(this);
}