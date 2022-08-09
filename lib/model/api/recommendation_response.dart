import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RecommendationResponse extends Response<List<String>>{
  RecommendationResponse(String code, String message, List<String> data) : super(code: code, message: message, data: data);

  // factory RecommendationResponse.fromJson() =>
}