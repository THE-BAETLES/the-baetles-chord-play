import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../model/api/response/user/delete_my_collection_response.dart';
import '../../model/api/response/user/get_my_collection_response.dart';
import '../../model/api/response/user/get_my_collection_video_id_list_response.dart';
import '../../model/api/response/user/post_my_collection_response.dart';
import '../client.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/user")
abstract class UserClient extends RestClient {
  factory UserClient (Dio dio, {String baseUrl}) = _UserClient;

  @GET('/user/my-collection')
  Future<GetMyCollectionResponse> getMyCollection();

  @GET('/user/my-collection-video-id-list')
  Future<GetMyCollectionVideoIdListResponse> getMyCollectionVideoIdList();

  @POST('/user/my-collection/{videoId}')
  Future<PostMyCollectionResponse> postMyCollection(@Path("videoId") String videoId);

  @DELETE('/user/my-collection/{videoId}')
  Future<DeleteMyCollectionResponse> deleteMyCollection(@Path("videoId") String videoId);
}
