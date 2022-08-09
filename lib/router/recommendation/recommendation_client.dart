import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/model/api/recommendation/recommendation_response.dart';

part 'recommendation_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RecommendationClient {
  // single ton
  factory RecommendationClient (Dio dio, {String baseUrl}) = _RecommendationClient;
  // This class must include fromJson and toJson Methods;
  @GET("/tasks")
  Future<RecommendationResponse> getRecommendationList(@Query('offset') int offset, @Query('limit') int limit);
}
// @JsonSerializable(genericArgumentFactories: true)
// class Response<T> {
//   String code;
//   String message;
//   T? data;
//   Response({required this.code, required this.message, this.data});
// }
//
// @JsonSerializable()
// class RecommendationResponse extends Response<List<String>>{
//   RecommendationResponse(String code, String message, List<String> data) : super(code: code, message: message, data: data);
//   factory RecommendationResponse.fromJson(Map<String, dynamic> json) => _$RecommendationResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$RecommendationResponseToJson(this);
// }