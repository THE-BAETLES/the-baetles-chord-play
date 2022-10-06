import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:the_baetles_chord_play/presentation/home/video_grid.dart';

import '../../domain/model/video.dart';
import '../../widget/molecule/block_title.dart';

class VideoGridBlock extends StatelessWidget {
  final UnmodifiableListView<Video> videos;
  late final void Function(Video)? _onVideoClicked;

  VideoGridBlock({
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: BlockTitle(title: "추천 악보영상", subTitle: "이런 곡 연습은 어떠세요?"),
        ),
        VideoGrid(
          video: videos,
          onVideoClicked: _onVideoClicked,
        ),
      ],
    );
  }
}
