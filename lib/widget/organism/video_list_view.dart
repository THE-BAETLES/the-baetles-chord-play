import 'package:flutter/material.dart';

import '../../domain/model/video.dart';
import '../molecule/video_block.dart';

class VideoListView extends StatelessWidget {
  final List<Video> videos;
  final Function(Video video)? onVideoBlockClicked;
  final Widget? head;

  VideoListView({
    Key? key,
    required this.videos,
    this.head,
    this.onVideoBlockClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final List<Widget> listItems = [];

      if (head != null) {
        listItems.add(head!);
      }

      for (Video video in videos) {
        listItems.add(VideoBlock(
          video: video,
          onClick: onVideoBlockClicked,
        ));
      }

      return ListView(
        physics: const BouncingScrollPhysics(),
        children: listItems,
      );
    });
  }
}
