import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/video_card.dart';

import '../../domain/model/video.dart';

class VideoList extends StatelessWidget {
  late final List<Video> _videos;
  late final Function(Video)? _onVideoClicked;
  late final Function(double offset, double maxScrollExtent)? _scrollListener;

  VideoList({
    Key? key,
    required List<Video> video,
    void Function(Video)? onVideoClicked,
    void Function(double, double)? scrollListener,
  }) : super(key: key) {
    _videos = video;
    _onVideoClicked = onVideoClicked;
    _scrollListener = scrollListener;
  }

  @override
  Widget build(BuildContext context) {
    ScrollController? controller = ScrollController();

    if (_scrollListener != null) {
      controller.addListener(() {
        _scrollListener!.call(controller.offset, controller.position.maxScrollExtent);
      });
    }

    List<Widget> videoCards = [];

    // 맨 앞 공백
    videoCards.add(Container(width: 10));

    for (int i = 0; i < _videos.length; ++i) {
      Video video = _videos[i];

      videoCards.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: VideoCard(
          video: video,
          onVideoClicked: _onVideoClicked,
        ),
      ));
    }

    // 맨 뒤 공백
    videoCards.add(Container(width: 10));

    return SizedBox(
      height: 274,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        controller: controller,
        children: videoCards,
      ),
    );
  }

  void addVideos(final List<Video> newVideos) {
    _videos.addAll(newVideos);
  }
}
