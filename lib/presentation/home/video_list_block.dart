import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/presentation/home/video_list.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/block_title.dart';

class VideoListBlock extends StatelessWidget {
  final List<Video> videos;
  final String title;
  final String subTitle;
  final Function(Video)? onVideoClicked;
  final Function(double offset, double maxScrollExtent)? scrollListener;

  VideoListBlock({
    Key? key,
    required this.videos,
    required this.title,
    required this.subTitle,
    this.onVideoClicked,
    this.scrollListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: BlockTitle(
            title: title,
            subTitle: subTitle,
          ),
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
