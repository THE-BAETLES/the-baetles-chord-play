import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  final YoutubePlayerController _controller;

  const YoutubeVideoPlayer({
    Key? key,
    required YoutubePlayerController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: false,
        )
        // child: YoutubePlayerIFrame(
        //   controller: YoutubePlayerController(
        //     initialVideoId: vid,
        //     params: const YoutubePlayerParams(
        //       autoPlay: true,
        //       enableCaption: false,
        //       captionLanguage: 'en',
        //       enableKeyboard: false,
        //       showVideoAnnotations: false,
        //     ),
        //   ),
        // ),
    );
  }
}
