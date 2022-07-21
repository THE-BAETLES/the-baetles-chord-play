import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:the_baetles_chord_play/presentation/sign_up/component/video_radio_button.dart';

import '../../../domain/model/video.dart';

class VideoRadioButtonList extends StatelessWidget {
  final UnmodifiableListView<Video> videos;
  final void Function(Video, bool) onChange;

  const VideoRadioButtonList({
    Key? key,
    required this.videos,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    for (int i = 0; i < videos.length; ++i) {
      buttons.add(SizedBox(
        width: 90,
        height: 115,
        child: VideoRadioButton(
          videos[i].thumbnailPath,
          videos[i].title,
          (bool isActivated) {
            onChange(videos[i], isActivated);
          },
        ),
      ));
    }

    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 7.5,
      mainAxisSpacing: 13.5,
      crossAxisCount: 3,
      children: buttons,
    );
  }
}
