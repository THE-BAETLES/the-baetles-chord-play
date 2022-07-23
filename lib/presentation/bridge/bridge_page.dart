import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/widget/organism/transparent_appbar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../domain/model/video.dart';

class BridgePage extends StatelessWidget {
  const BridgePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Video video = ModalRoute.of(context)!.settings.arguments as Video;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: TransparentAppbar(),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: YoutubePlayerIFrame(
                controller: YoutubePlayerController(
                  initialVideoId: video.id,
                  params: const YoutubePlayerParams(
                    autoPlay: true,
                    enableCaption: false,
                    captionLanguage: 'en',
                    enableKeyboard: false,
                    showVideoAnnotations: false,
                  ),
                ),
              ),
            ),

          ],
        ));
  }
}
