import 'package:flutter/cupertino.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  final String vid;

  const YoutubeVideoPlayer({Key? key, required this.vid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: YoutubePlayerIFrame(
        controller: YoutubePlayerController(
          initialVideoId: vid,
          params: const YoutubePlayerParams(
            autoPlay: true,
            enableCaption: false,
            captionLanguage: 'en',
            enableKeyboard: false,
            showVideoAnnotations: false,
          ),
        ),
      ),
    );
  }
}
