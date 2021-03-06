import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_card.dart';

import '../../domain/model/video.dart';

class VideoList extends StatelessWidget {
  late final List<Video> _videos;
  late final void Function(Video)? _onVideoClicked;

  VideoList({
    Key? key,
    required List<Video> video,
    void Function(Video)? onVideoClicked,
  }) : super(key: key) {
    _videos = video;
    _onVideoClicked = onVideoClicked;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> videoCards = [];

    // 맨 앞 공백
    videoCards.add(Container(width: 10));

    for (int i = 0; i < _videos.length; ++i) {
      Video video = _videos[i];

      videoCards.add(Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: VideoCard(
          video: video,
          onVideoClicked: _onVideoClicked,
        ),
      ));
    }

    // 맨 뒤 공백
    videoCards.add(Container(width: 10));

    return Container(
      height: 274,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: videoCards,
      ),
    );
  }

  void addVideos(final List<Video> newVideos) {
    _videos.addAll(newVideos);
  }
}
