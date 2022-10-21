import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/home/video_list.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/block_title.dart';

class VideoListBlock extends StatelessWidget {
  final List<Video> videos;
  final String userName;
  final Function(Video)? onVideoClicked;
  final Function(double offset, double maxScrollExtent)? scrollListener;

  VideoListBlock({
    Key? key,
    required this.videos,
    required this.userName,
    this.onVideoClicked,
    this.scrollListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: BlockTitle(
              title: "연주했던 곡", subTitle: "${this.userName}님이 연습했던 악보영상들"),
        ),
        VideoList(
          video: videos,
          onVideoClicked: onVideoClicked,
          scrollListener: scrollListener,
        ),
      ],
    );
  }
}
