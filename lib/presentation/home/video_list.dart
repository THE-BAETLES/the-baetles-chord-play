import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_card.dart';

import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/molecule/block_title.dart';

class VideoList extends StatelessWidget {
  late final List<Video> _videos;

  VideoList({required List<Video> video, Key? key}) : super(key: key) {
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
        const BlockTitle(title: "연주했던 곡", subTitle: "소유님이 연습했던 악보영상들"),
        Container(
          height: 274,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: videoCards,
          ),
        ),
      ],
    );
  }

  void addVideos(final List<Video> newVideos) {
    _videos.addAll(newVideos);
  }
}
