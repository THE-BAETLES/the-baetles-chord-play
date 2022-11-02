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
          id: 'https://img.youtube.com/vi/KvthiAoGTfo/0.jpg',
          thumbnailPath: 'https://img.youtube.com/vi/KvthiAoGTfo/0.jpg',
          title: '벚꽃 엔딩',
          genre: 'acoustic',
          tags: ['기타', '밴드'],
          length: 261,
          singer: '버스커 버스커',
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'iM0GXk9oArE',
          thumbnailPath: 'https://img.youtube.com/vi/iM0GXk9oArE/0.jpg',
          title: '봄봄봄',
          genre: 'idol',
          tags: ['sadf'],
          length: 340,
          singer: '로이킴',
          difficultyAvg: 2,
          playCount: 42352,
          sheetCount: 3,
          isInMyCollection: false,
        ),
        Video(
          id: 'f6YDKF0LVWw',
          thumbnailPath: 'https://img.youtube.com/vi/f6YDKF0LVWw/0.jpg',
          title: 'NAYEON "POP!" M/V',
          genre: 'idol',
          singer: 'JYP Entertainment',
          tags: ['idol'],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'wWOky-2Ab9Q',
          thumbnailPath: 'https://img.youtube.com/vi/wWOky-2Ab9Q/0.jpg',
          title: '옛 사랑',
          genre: '',
          singer: '이문세',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'NE3txQBtXKc',
          thumbnailPath: 'https://img.youtube.com/vi/NE3txQBtXKc/0.jpg',
          title: '사랑했지만',
          genre: '',
          singer: '김광석',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'SZkkZLSCv44',
          thumbnailPath: 'https://img.youtube.com/vi/SZkkZLSCv44/0.jpg',
          title: '너에게 난, 나에게 넌',
          genre: '',
          singer: '자전거 탄 풍경',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'gPgxBHRA0lc',
          thumbnailPath: 'https://img.youtube.com/vi/gPgxBHRA0lc/0.jpg',
          title: '걱정말아요 그대',
          genre: '',
          singer: '이적',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'bVrW1eDMtL8',
          thumbnailPath: 'https://img.youtube.com/vi/bVrW1eDMtL8/0.jpg',
          title: '위잉위잉',
          genre: '',
          singer: '혁오',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'ZO1xdXOXarc',
          thumbnailPath: 'https://img.youtube.com/vi/ZO1xdXOXarc/0.jpg',
          title: '봄날',
          genre: '',
          singer: '방탄소년단',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: '_pcl_JPqMfw',
          thumbnailPath: 'https://img.youtube.com/vi/_pcl_JPqMfw/0.jpg',
          title: '흔들리는 꽃들 속에서 네 샴푸향이 느껴진거야',
          genre: '',
          singer: '장범준',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'fdz_cabS9BU',
          thumbnailPath: 'https://img.youtube.com/vi/fdz_cabS9BU/0.jpg',
          title: 'Thinking out Loud',
          genre: '',
          singer: 'Ed sheeran',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'N3K1fpQaClQ',
          thumbnailPath: 'https://img.youtube.com/vi/N3K1fpQaClQ/0.jpg',
          title: 'Paris in the Rain',
          genre: '',
          singer: 'Lauv',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'ELEVEN',
          genre: 'idol',
          singer: '아이브',
          tags: ['idol'],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'aZCfbL5oIeI',
          thumbnailPath: 'https://img.youtube.com/vi/aZCfbL5oIeI/0.jpg',
          title: 'Eul (Feat. BIG Naughty) (을 (Feat. BIG Naughty (서동현)))',
          genre: 'hip-hop',
          singer: '기리보이',
          tags: ['hip-hop'],
          length: 179,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
          isInMyCollection: false,
        ),
        Video(
          id: 'HaOz1PhGXhs',
          thumbnailPath: 'https://img.youtube.com/vi/HaOz1PhGXhs/0.jpg',
          title: 'LAST DANCE',
          genre: '',
          singer: 'BIGBANG',
          tags: [''],
          length: 0,
          difficultyAvg: 0,
          playCount: 0,
          sheetCount: 0,
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
