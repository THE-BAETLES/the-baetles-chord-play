import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_video_collection.dart';
import 'package:the_baetles_chord_play/model/api/response/video/get_video_grade_collection_response.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import '../../model/api/response/watch_history/watch_history_response.dart';

part 'video_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/watch-history")
abstract class VideoClient extends RestClient {
  factory VideoClient(Dio dio, {String baseUrl}) = _VideoClient;
  @GET('grade-collection')
  Future<GetVideoGradeCollectionResponse> getWatchHistory(@Query('performerGrade') String performerGrade);
}