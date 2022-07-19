import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BridgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("브릿지 페이지"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () { print("clicked!"); },
                    child: Text("start"),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                YoutubePlayerIFrame(
                    controller: YoutubePlayerController(
                      initialVideoId: 'WxM0qO29RM8',
                      params: YoutubePlayerParams(
                        autoPlay: false,
                        enableCaption: false,
                        captionLanguage: "en",
                        enableKeyboard: false,
                        showVideoAnnotations: false,
                      )
                    ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('곡 제목'),
                    Text('이것 저것'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}