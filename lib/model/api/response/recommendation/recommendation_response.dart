import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation_response.g.dart';

@JsonSerializable()
class RecommendationResponse extends Response<List<String>>{
  RecommendationResponse(String code, String message, List<String> data) : super(code: code, message: message, data: data);
  factory RecommendationResponse.fromJson(Map<String, dynamic> json) => _$RecommendationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationResponseToJson(this);
}