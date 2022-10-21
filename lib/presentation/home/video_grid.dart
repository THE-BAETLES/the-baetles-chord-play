import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/molecule/block_title.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/video_card.dart';

class VideoGrid extends StatelessWidget {
  late final List<Video> _videos;
  late final void Function(Video)? _onVideoClicked;
  late final void Function(double offset, double maxScrollExtent)? _scrollListener;

  VideoGrid({
    Key? key,
    required List<Video> videos,
    void Function(Video)? onVideoClicked,
    void Function(double offset, double maxScrollExtent)? scrollListener,
  }) : super(key: key) {
    _videos = videos;
    _onVideoClicked = onVideoClicked;
    _scrollListener = scrollListener;
  }

  @override
  Widget build(BuildContext context) {
    ScrollController? controller;

    if (_scrollListener != null) {
      controller = ScrollController();
      controller!.addListener(() {
        _scrollListener!.call(controller!.offset, controller!.position.maxScrollExtent);
      });
    }

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
        controller: controller,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
