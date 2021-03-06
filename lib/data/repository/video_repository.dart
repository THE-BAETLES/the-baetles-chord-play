import 'dart:collection';

import '../../domain/model/performer_grade.dart';
import '../../domain/model/video.dart';

class VideoRepository {
  static final VideoRepository _instance = VideoRepository._internal();

  factory VideoRepository() {
    return _instance;
  }

  VideoRepository._internal() {
    // TODO : source 연결
  }

  Future<UnmodifiableListView<Video>> fetchVideosToCheckPreference(
    String countryCode,
    PerformerGrade performerGrade,
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
          singer: 'JYP Entertainment',
          difficulty: 2,
          playCount: 32222432,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'IVE 아이브 \'ELEVEN\' MV',
          genre: 'idol',
          singer: 'starshipTV',
          difficulty: 2,
          playCount: 41042,
        ),
        Video(
          id: 'aZCfbL5oIeI',
          thumbnailPath: 'https://img.youtube.com/vi/aZCfbL5oIeI/0.jpg',
          title: 'Eul (Feat. BIG Naughty) (을 (Feat. BIG Naughty (서동현)))',
          genre: 'hip-hop',
          singer: 'GIRIBOY',
          difficulty: 2,
          playCount: 42333333332,
        ),
        Video(
          id: 'pnaQ9CbE6P0',
          thumbnailPath: 'https://img.youtube.com/vi/pnaQ9CbE6P0/0.jpg',
          title: '자우림 \'스물다섯, 스물하나\' 어쿠스틱커버 by 장범준 Acoustic COVER',
          genre: 'performance',
          singer: '장범준',
          difficulty: 5,
          playCount: 7671806,
        ),
        Video(
          id: 'YwC0m0XaD2E',
          thumbnailPath: 'https://img.youtube.com/vi/YwC0m0XaD2E/0.jpg',
          title: '최고의 피카츄 월드컵 (※동심파괴 주의)',
          genre: 'idol',
          singer: '침착맨',
          difficulty: 2,
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
          singer: 'JYP Entertainment',
          difficulty: 2,
          playCount: 32222432,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'IVE 아이브 \'ELEVEN\' MV',
          genre: 'idol',
          singer: 'starshipTV',
          difficulty: 2,
          playCount: 41042,
        ),
        Video(
          id: 'aZCfbL5oIeI',
          thumbnailPath: 'https://img.youtube.com/vi/aZCfbL5oIeI/0.jpg',
          title: 'Eul (Feat. BIG Naughty) (을 (Feat. BIG Naughty (서동현)))',
          genre: 'hip-hop',
          singer: 'GIRIBOY',
          difficulty: 2,
          playCount: 42333333332,
        ),
        Video(
          id: 'pnaQ9CbE6P0',
          thumbnailPath: 'https://img.youtube.com/vi/pnaQ9CbE6P0/0.jpg',
          title: '자우림 \'스물다섯, 스물하나\' 어쿠스틱커버 by 장범준 Acoustic COVER',
          genre: 'performance',
          singer: '장범준',
          difficulty: 5,
          playCount: 7671806,
        ),
        Video(
          id: 'YwC0m0XaD2E',
          thumbnailPath: 'https://img.youtube.com/vi/YwC0m0XaD2E/0.jpg',
          title: '최고의 피카츄 월드컵 (※동심파괴 주의)',
          genre: 'idol',
          singer: '침착맨',
          difficulty: 2,
          playCount: 42352,
        ),
      ]);
    })();
  }

  Future<UnmodifiableListView<Video>> fetchRecommededVideos(String idToken,) async {
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
          difficulty: 2,
          playCount: 32222432,
        ),
        Video(
          id: '--FmExEAsM8',
          thumbnailPath: 'https://img.youtube.com/vi/--FmExEAsM8/0.jpg',
          title: 'IVE 아이브 \'ELEVEN\' MV',
          genre: 'idol',
          singer: 'starshipTV',
          difficulty: 2,
          playCount: 41042,
        ),
        Video(
          id: 'aZCfbL5oIeI',
          thumbnailPath: 'https://img.youtube.com/vi/aZCfbL5oIeI/0.jpg',
          title: 'Eul (Feat. BIG Naughty) (을 (Feat. BIG Naughty (서동현)))',
          genre: 'hip-hop',
          singer: 'GIRIBOY',
          difficulty: 2,
          playCount: 42333333332,
        ),
        Video(
          id: 'pnaQ9CbE6P0',
          thumbnailPath: 'https://img.youtube.com/vi/pnaQ9CbE6P0/0.jpg',
          title: '자우림 \'스물다섯, 스물하나\' 어쿠스틱커버 by 장범준 Acoustic COVER',
          genre: 'performance',
          singer: '장범준',
          difficulty: 5,
          playCount: 7671806,
        ),
        Video(
          id: 'YwC0m0XaD2E',
          thumbnailPath: 'https://img.youtube.com/vi/YwC0m0XaD2E/0.jpg',
          title: '최고의 피카츄 월드컵 (※동심파괴 주의)',
          genre: 'idol',
          singer: '침착맨',
          difficulty: 2,
          playCount: 42352,
        ),
      ]);
    })();
  }
}
