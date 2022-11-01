import 'package:the_baetles_chord_play/model/api/response/user/delete_my_collection_response.dart';
import 'package:the_baetles_chord_play/model/api/response/user/post_my_collection_response.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';

import '../../domain/model/video.dart';
import '../../model/api/response/user/get_my_collection_response.dart';
import '../../model/api/response/user/get_my_collection_video_id_list_response.dart';
import '../../model/schema/video/video_schema.dart';
import '../../router/client.dart';
import '../../router/user/user_client.dart';

class CollectionRepository {
  static final CollectionRepository _instance = CollectionRepository._internal();

  final List<Function()> myCollectionChangeListeners = [];

  factory CollectionRepository() {
    return _instance;
  }

  CollectionRepository._internal();

  Future<List<Video>> getMyCollection() async {
    UserClient client = RestClientFactory().getClient(RestClientType.user) as UserClient;
    GetMyCollectionResponse response = await client.getMyCollection();
    List<VideoSchema> videos = response.data!;
    List<Video> result = [];

    for (VideoSchema video in videos) {
      result.add(video.toVideo());
    }

    return result;
  }

  Future<List<String>> getMyCollectionVideoIdList() async {
    UserClient client = RestClientFactory().getClient(RestClientType.user) as UserClient;
    GetMyCollectionVideoIdListResponse response = await client.getMyCollectionVideoIdList();

    return response.data!;
  }

  Future<void> addToMyCollection(String videoId) async {
    UserClient client = RestClientFactory().getClient(RestClientType.user) as UserClient;
    PostMyCollectionResponse response = await client.postMyCollection(videoId);

    _alertChange();
    return;
  }

  Future<void> deleteFromMyCollection(String videoId) async {
    UserClient client = RestClientFactory().getClient(RestClientType.user) as UserClient;
    DeleteMyCollectionResponse response = await client.deleteMyCollection(videoId);

    _alertChange();
    return;
  }

  void addMyCollectionChangeListener(Function() listener) {
    myCollectionChangeListeners.add(listener);
  }

  void removeMyCollectionChangeListener(Function() listener) {
    myCollectionChangeListeners.remove(listener);
  }

  void _alertChange() {
    for (final listener in myCollectionChangeListeners) {
      listener();
    }
  }
}