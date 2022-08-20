import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

import '../../../../domain/model/video.dart';

part 'get_watch_history_response.g.dart';

@JsonSerializable()
class GetWatchHistoryResponse extends Response<List<VideoSchema>>{
  GetWatchHistoryResponse(String code, String message, List<VideoSchema> data) : super(code: code, message: message, data:data);
  factory GetWatchHistoryResponse.fromJson(Map<String, dynamic> json) => _$GetWatchHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetWatchHistoryResponseToJson(this);

  List<Video> toVideoList() {
    final List<Video> videoList = [];

    for (VideoSchema videoSchema in data!) {
      videoList.add(videoSchema.toVideo());
    }

    return videoList;
  }
}