import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/home/video_list.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/block_title.dart';

class VideoListBlock extends StatelessWidget {
  final List<Video> videos;
  late final void Function(Video)? _onVideoClicked;

  VideoListBlock({
    Key? key,
    required this.videos,
    void Function(Video)? onVideoClicked,
  }) : super(key: key) {
    _onVideoClicked = onVideoClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BlockTitle(title: "연주했던 곡", subTitle: "소유님이 연습했던 악보영상들"),
        VideoList(
          video: videos,
          onVideoClicked: _onVideoClicked,
        ),
      ],
    );
  }
}
