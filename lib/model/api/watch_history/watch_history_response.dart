import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

part 'watch_history_response.g.dart';

@JsonSerializable()
class WatchHistoryResponse extends Response<List<VideoSchema>>{
  WatchHistoryResponse(String code, String message, List<VideoSchema> data) : super(code: code, message: message, data:data);
  factory WatchHistoryResponse.fromJson(Map<String, dynamic> json) => _$WatchHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WatchHistoryResponseToJson(this);
}