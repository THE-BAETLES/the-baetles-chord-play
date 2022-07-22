import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/home/video_list.dart';

import '../../domain/model/video.dart';

class HistoryBlock extends StatelessWidget {
  HistoryBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoList(
      video: videos,
    );
  }

  // dummy data
  List<Video> videos = [
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
  ];
}
