import 'dart:collection';

import 'package:the_baetles_chord_play/model/api/response/search/get_search_response.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';

import '../../domain/model/performer_grade.dart';
import '../../domain/model/video.dart';
import '../../model/api/response/response.dart';
import '../../router/client.dart';
import '../../router/search/search_client.dart';

class VideoRepository {
  static final VideoRepository _instance = VideoRepository._internal();

  factory VideoRepository() {
    return _instance;
  }

  VideoRepository._internal() {
    // TODO : source 연결
  }

  Future<UnmodifiableListView<Video>> fetchVideosToCheckPreference(
      String idToken,
      String countryCode,
      String performerGrade,
      String gender) async {
    // TODO : source 연결
    //

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
        ),
      ]);
    })();
  }

  Future<UnmodifiableListView<Video>> fetchVideoCollection(
    String idToken,
  ) async {
    // TODO : source 연결

    // dummy data
    return await (() async {
      return UnmodifiableListView<Video>([
        Video(
          id: 'f6YDKF0LVWw',
          thumbnailPath: 'https://img.youtube.com/vi/f6YDKF0LVWw/0.jpg',
          title: 'NAYEON "POP!" M/V',
          genre: 'idol',
          tags: ['sadf'],
          length: 340,
          singer: 'JYP Entertainment',
          difficultyAvg: 2,
          playCount: 32222432,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'IVE 아이브 \'ELEVEN\' MV',
          genre: 'idol',
          tags: ['sadf'],
          length: 340,
          singer: 'starshipTV',
          difficultyAvg: 2,
          playCount: 41042,
        ),
        Video(
          id: 'aZCfbL5oIeI',
          thumbnailPath: 'https://img.youtube.com/vi/aZCfbL5oIeI/0.jpg',
          title: 'Eul (Feat. BIG Naughty) (을 (Feat. BIG Naughty (서동현)))',
          genre: 'hip-hop',
          tags: ['sadf'],
          length: 340,
          singer: 'GIRIBOY',
          difficultyAvg: 2,
          playCount: 42333333332,
        ),
        Video(
          id: 'pnaQ9CbE6P0',
          thumbnailPath: 'https://img.youtube.com/vi/pnaQ9CbE6P0/0.jpg',
          title: '자우림 \'스물다섯, 스물하나\' 어쿠스틱커버 by 장범준 Acoustic COVER',
          genre: 'performance',
          singer: '장범준',
          difficultyAvg: 5,
          tags: ['sadf'],
          length: 340,
          playCount: 7671806,
        ),
        Video(
          id: 'YwC0m0XaD2E',
          thumbnailPath: 'https://img.youtube.com/vi/YwC0m0XaD2E/0.jpg',
          title: '최고의 피카츄 월드컵 (※동심파괴 주의)',
          tags: ['sadf'],
          length: 340,
          genre: 'idol',
          singer: '침착맨',
          difficultyAvg: 2,
          playCount: 42352,
        ),
      ]);
    })();
  }

  Future<UnmodifiableListView<Video>> fetchRecommededVideos(
    String idToken,
  ) async {
    // TODO : source 연결

    // dummy data
    return await (() async {
      return UnmodifiableListView<Video>([
        Video(
          id: 'f6YDKF0LVWw',
          thumbnailPath: 'https://img.youtube.com/vi/f6YDKF0LVWw/0.jpg',
          title: 'NAYEON "POP!" M/V',
          tags: ['sadf'],
          length: 340,
          genre: 'idol',
          singer: 'JYP Entertainment',
          difficultyAvg: 2,
          playCount: 32222432,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'IVE 아이브 \'ELEVEN\' MV',
          tags: ['sadf'],
          length: 340,
          genre: 'idol',
          singer: 'starshipTV',
          difficultyAvg: 2,
          playCount: 41042,
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
        ),
        Video(
          id: 'YwC0m0XaD2E',
          thumbnailPath: 'https://img.youtube.com/vi/YwC0m0XaD2E/0.jpg',
          title: '최고의 피카츄 월드컵 (※동심파괴 주의)',
          genre: 'idol',
          singer: '침착맨',
          difficultyAvg: 2,
          tags: ['sadf'],
          length: 340,
          playCount: 42352,
        ),
      ]);
    })();
  }

  Future<List<Video>> searchVideo(String searchTitle) async {
    SearchClient client = RestClientFactory().getClient(RestClientType.search) as SearchClient;
    GetSearchResponse response = await client.getSearchList(searchTitle);
    List<Video> searchResult = response.toVideoList();
    return searchResult;
  }
}
