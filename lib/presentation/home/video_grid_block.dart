import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:the_baetles_chord_play/presentation/home/video_grid.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/block_title.dart';

class VideoGridBlock extends StatelessWidget {
  final List<Video> videos;
  final void Function(double offset, double maxScrollExtent)? scrollListener;
  final void Function(Video)? onVideoClicked;

  VideoGridBlock({
    Key? key,
    required this.videos,
    this.scrollListener,
    this.onVideoClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: BlockTitle(title: "추천 악보영상", subTitle: "이런 곡 연습은 어떠세요?"),
        ),
        VideoGrid(
          videos: videos,
          onVideoClicked: onVideoClicked,
          scrollListener: scrollListener,
        ),
      ],
    );
  }
}
