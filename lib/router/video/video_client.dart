import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/model/api/request/video/post_video_request.dart';
import 'package:the_baetles_chord_play/model/api/response/video/get_video_grade_collection_response.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import '../../model/api/response/video/get_recommendation_response.dart';
import '../../model/api/response/video/get_video_response.dart';
import '../../model/api/response/video/post_video_response.dart';
import '../../model/api/response/video/get_watch_history_response.dart';

part 'video_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class VideoClient extends RestClient {
  factory VideoClient(Dio dio, {String baseUrl}) = _VideoClient;

  @GET('/videos/{videoId}')
  Future<GetVideoResponse> getVideo(@Path('videoId') String videoId);

  @GET('/videos/grade-collection')
  Future<GetVideoGradeCollectionResponse> getGradeCollection(@Query('performerGrade') String performerGrade);

  @GET('/videos/watch-history')
  Future<GetWatchHistoryResponse> getWatchHistory(@Query('offset') int offset, @Query('limit') int limit);

  @POST('/videos/{videoId}')
  Future<PostVideoResponse> postVideo(@Path('videoId') String videoId, @Body() PostVideoRequest postVideoRequest);

  @GET('/recommendation')
  Future<GetRecommendationResponse> getRecommendation(@Query('offset') int offset, @Query('limit') int limit);
}