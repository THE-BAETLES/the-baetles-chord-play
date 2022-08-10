import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../model/api/response/watch_history/watch_history_response.dart';
part 'watch_history_client.g.dart';
@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/watch-history")
abstract class WatchHistoryClient {
  factory WatchHistoryClient(Dio dio, {String baseUrl}) = _WatchHistoryClient;
  @GET('')
  Future<WatchHistoryResponse> getWatchHistory(@Query('offset') int offset,@Query('limit') int limit);
}