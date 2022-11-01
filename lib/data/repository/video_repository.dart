import 'dart:collection';

import 'package:the_baetles_chord_play/model/api/request/video/post_video_request.dart';
import 'package:the_baetles_chord_play/model/api/response/search/get_search_response.dart';
import 'package:the_baetles_chord_play/model/api/response/video/get_video_response.dart';
import 'package:the_baetles_chord_play/model/api/response/video/get_watch_history_response.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';
import 'package:the_baetles_chord_play/router/video/video_client.dart';

import '../../domain/model/performer_grade.dart';
import '../../domain/model/video.dart';
import '../../model/api/response/response.dart';
import '../../model/api/response/video/get_recommendation_response.dart';
import '../../model/api/response/video/post_video_response.dart';
import '../../model/schema/video/video_schema.dart';
import '../../router/client.dart';
import '../../router/search/search_client.dart';

class VideoRepository {
  static final VideoRepository _instance = VideoRepository._internal();

  factory VideoRepository() {
    return _instance;
  }

  VideoRepository._internal() {}

  Future<UnmodifiableListView<Video>> fetchVideosToCheckPreference(
      String idToken,
      String countryCode,
      String performerGrade,
      String gender) async {
    // TODO : source 연결

    // dummy data
    return await (() async {
      return UnmodifiableListView<Video>([
        Video(
          id: 'f6YDKF0LVWw',
          thumbnailPath: 'https://img.youtube.com/vi/f6YDKF0LVWw/0.jpg',
          title: 'NAYEON "POP!" M/V',
          genre: 'idol',
          singer: 'JYP Entertainment',
          tags: ['sadf'],
          length: 340,
          difficultyAvg: 2,
          playCount: 32222432,
          sheetCount: 3,
          isInMyCollection: false,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'IVE 아이브 \'ELEVEN\' MV',
          genre: 'idol',
          singer: 'starshipTV',
          tags: ['sadf'],
          length: 340,
          difficultyAvg: 2,
          playCount: 41042,
          sheetCount: 3,
          isInMyCollection: false,
        ),
        Video(
          id: 'aZCfbL5oIeI',
          thumbnailPath: 'https://img.youtube.com/vi/aZCfbL5oIeI/0.jpg',
          title: 'Eul (Feat. BIG Naughty) (을 (Feat. BIG Naughty (서동현)))',
          genre: 'hip-hop',
          singer: 'GIRIBOY',
          tags: ['sadf'],
          length: 340,
          difficultyAvg: 2,
          playCount: 42333333332,
          sheetCount: 3,
          isInMyCollection: false,
        ),
        Video(
          id: 'pnaQ9CbE6P0',
          thumbnailPath: 'https://img.youtube.com/vi/pnaQ9CbE6P0/0.jpg',
          title: '자우림 \'스물다섯, 스물하나\' 어쿠스틱커버 by 장범준 Acoustic COVER',
          genre: 'performance',
          tags: ['sadf'],
          length: 340,
          singer: '장범준',
          difficultyAvg: 5,
          playCount: 7671806,
          sheetCount: 3,
          isInMyCollection: false,
        ),
        Video(
          id: 'YwC0m0XaD2E',
          thumbnailPath: 'https://img.youtube.com/vi/YwC0m0XaD2E/0.jpg',
          title: '최고의 피카츄 월드컵 (※동심파괴 주의)',
          genre: 'idol',
          tags: ['sadf'],
          length: 340,
          singer: '침착맨',
          difficultyAvg: 2,
          playCount: 42352,
          sheetCount: 3,
          isInMyCollection: false,
        ),
      ]);
    })();
  }


  Future<UnmodifiableListView<Video>> fetchRecommendedVideos({
    int offset = 0,
    int limit = 25,
  }) async {
    VideoClient client =
        RestClientFactory().getClient(RestClientType.video) as VideoClient;
    GetRecommendationResponse response =
        await client.getRecommendation(offset, limit);
    List<Video> videos = response.toVideoList();

    return UnmodifiableListView(videos);
  }

  Future<List<Video>> searchVideo(String searchTitle) async {
    SearchClient client =
        RestClientFactory().getClient(RestClientType.search) as SearchClient;
    GetSearchResponse response = await client.getSearchList(searchTitle);
    List<Video> searchResult = response.toVideoList();
    return searchResult;
  }

  Future<Video> generateVideo(Video video) async {
    VideoClient client =
        RestClientFactory().getClient(RestClientType.video) as VideoClient;
    PostVideoResponse response = await client.postVideo(
      video.id,
      PostVideoRequest(video: VideoSchema.fromVideo(video)),
    );
    return response.data!.toVideo();
  }

  Future<List<Video>> getWatchHistory({int offset = 0, int limit = 25}) async {
    VideoClient client =
        RestClientFactory().getClient(RestClientType.video) as VideoClient;
    GetWatchHistoryResponse response = await client.getWatchHistory(offset, limit);
    return response.toVideoList();
  }

  Future<Video?> getVideoById(String videoId) async {
    VideoClient client = RestClientFactory().getClient(RestClientType.video) as VideoClient;
    GetVideoResponse response = await client.getVideo(videoId);
    return response.data?.toVideo();
  }
}
