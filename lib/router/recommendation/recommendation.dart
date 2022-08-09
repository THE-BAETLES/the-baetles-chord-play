import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recommendation.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RecommendationClient {
  factory RecommendationClient (Dio dio, {String baseUrl}) = _RecommendationClient;
  @GET("/tasks")
  Future<List<String>> getTasks();
}

@JsonSerializable()
class Recommendation {

}