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
          id: "q_WMoSdsXRk",
          thumbnailPath:
              "https://i.ytimg.com/vi/q_WMoSdsXRk/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AOn4CLA1X0WqNqn5pcUEGDv7qwLgLBgQYw",
          title: "The Cheetah Girls - Feels Like Love(Official Music Video)",
          genre: "romance",
          singer: "cheetagirl",
          difficulty: 3,
          playCount: 35,
        ),
        Video(
          id: 'C3XR1T7Ey5M',
          thumbnailPath:
              'https://i.ytimg.com/vi/C3XR1T7Ey5M/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AOn4CLC1kAXR85T9L-iKQf8JLq842cKsJA',
          title: 'Step Up',
          genre: 'action',
          singer: 'TheCheetahGirlsVEVO',
          difficulty: 2,
          playCount: 3222,
        ),
        Video(
          id: 'C3XR1T7Ey5M',
          thumbnailPath:
          'https://i.ytimg.com/vi/obX59oAcy_g/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AOn4CLDtYq2lWkuYppgoJgrR8t4R0iq7lA',
          title: 'Step Up',
          genre: 'action',
          singer: 'TheCheetahGirlsVEVO',
          difficulty: 2,
          playCount: 3222,
        ),
        Video(
          id: 'C3XR1T7Ey5M',
          thumbnailPath:
          'https://i.ytimg.com/vi/TrjVL6o_z6E/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AOn4CLBOcTxwvvMrHiXmWoUvkdFsb3tn7w',
          title: 'Step Up',
          genre: 'action',
          singer: 'TheCheetahGirlsVEVO',
          difficulty: 2,
          playCount: 3222,
        ),
        Video(
          id: 'C3XR1T7Ey5M',
          thumbnailPath:
          'https://i.ytimg.com/vi/rZpSOSfymV4/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AOn4CLBCM8TOEogwRow0STIspBou5Js2DQ',
          title: 'Step Up',
          genre: 'action',
          singer: 'TheCheetahGirlsVEVO',
          difficulty: 2,
          playCount: 3222,
        ),
        Video(
          id: 'C3XR1T7Ey5M',
          thumbnailPath:
          'https://i.ytimg.com/vi/c8mD8plPTxw/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AOn4CLApHCafVNJ3092Gv1XQV7SD0UDuCA',
          title: 'Step Up',
          genre: 'action',
          singer: 'TheCheetahGirlsVEVO',
          difficulty: 2,
          playCount: 3222,
        ),
      ]);
    })();
  }
}
