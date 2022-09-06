import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

import '../../../../domain/model/video.dart';
import '../response.dart';

part 'get_recommendation_response.g.dart';

@JsonSerializable()
class GetRecommendationResponse extends Response<List<VideoSchema>> {
  GetRecommendationResponse(String code, String message, List<VideoSchema> data) : super(code: code, message: message, data: data);
  factory GetRecommendationResponse.fromJson(Map<String, dynamic> json) => _$GetRecommendationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetRecommendationResponseToJson(this);

  List<Video> toVideoList() {
    return data!.map((e) => e.toVideo()).toList();
  }
}