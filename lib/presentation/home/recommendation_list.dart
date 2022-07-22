import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/block_title.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/video_card.dart';

class RecommendationList extends StatelessWidget {
  late final List<Video> _videos;

  RecommendationList({required List<Video> video, Key? key}) : super(key: key) {
    this._videos = video;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> videoCards = [];

    // 맨 앞 공백
    videoCards.add(Container(width: 10));

    for (int i = 0; i < _videos.length; ++i) {
      Video video = _videos[i];

      videoCards.add(VideoCard(video: video));
    }

    // 맨 뒤 공백
    videoCards.add(Container(width: 10));

    return Column(
      children: [
        BlockTitle(title: "추천 악보영상", subTitle: "이런 곡 연습은 어떠세요?"),
        Container(
          height: 596,
          child: GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.horizontal,
            children: videoCards,
          ),
        ),
      ],
    );
  }
}
