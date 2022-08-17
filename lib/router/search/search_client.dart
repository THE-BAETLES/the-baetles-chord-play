import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import '../../model/api/response/search/get_search_response.dart';
part 'search_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class SearchClient extends RestClient{
  // single ton
  factory SearchClient (Dio dio, {String baseUrl}) = _SearchClient;
  // This class must include fromJson and toJson Methods;
  @GET("/videos/search/")
  Future<GetSearchResponse> getSearchList(@Query('searchTitle') String searchTitle);
}

