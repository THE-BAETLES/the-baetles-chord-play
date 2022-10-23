import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatelessWidget {
  final YoutubePlayerController _controller;
  final double width;
  final double height;


  const YoutubeVideoPlayer({
    Key? key,
    required YoutubePlayerController controller,
    required this.width,
    required this.height,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
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
