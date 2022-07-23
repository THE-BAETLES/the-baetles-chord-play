import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/block_title.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/video_card.dart';

class VideoGrid extends StatelessWidget {
  late final List<Video> _videos;
  late final void Function(Video)? _onVideoClicked;

  VideoGrid({
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

    for (int i = 0; i < _videos.length; ++i) {
      Video video = _videos[i];

      videoCards.add(VideoCard(
        video: video,
        onVideoClicked: _onVideoClicked,
      ));
    }

    return Container(
      height: 554,
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        children: videoCards,
        shrinkWrap: true,
        childAspectRatio: 1.344086021505376,
        crossAxisSpacing: 30,
        mainAxisSpacing: 10,
      ),
    );
  }
}
