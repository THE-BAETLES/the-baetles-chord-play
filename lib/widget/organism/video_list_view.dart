import 'package:flutter/material.dart';

import '../../domain/model/video.dart';
import '../molecule/video_block.dart';

class VideoListView extends StatelessWidget {
  final List<Video> videos;
  final Function(Video video)? onVideoBlockClicked;

  VideoListView({
    Key? key,
    required this.videos,
    this.onVideoBlockClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final List<Widget> videoBlocks = [];

        for (Video video in videos) {
          videoBlocks.add(
            VideoBlock(
              video: video,
              onClick: onVideoBlockClicked,
            ),
          );
        }

        return ListView(
          children: videoBlocks,
        );
      }
    );
  }
}
