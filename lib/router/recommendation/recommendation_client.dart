import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import '../../model/api/response/recommendation/recommendation_response.dart';
part 'recommendation_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RecommendationClient extends RestClient{
  // single ton
  factory RecommendationClient (Dio dio, {String baseUrl}) = _RecommendationClient;
  // This class must include fromJson and toJson Methods;
  @GET("/recommendation")
  Future<RecommendationResponse> getRecommendationList(@Query('offset') int offset, @Query('limit') int limit);
}

