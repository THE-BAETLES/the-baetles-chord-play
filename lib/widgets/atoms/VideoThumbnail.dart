import 'package:flutter/material.dart';

class VideoThumbnail extends StatefulWidget {
  const VideoThumbnail({Key? key}) : super(key: key);

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [Image.network(
          "https://i.ytimg.com/vi/w-eWKu2flxI/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAx5kiWxXJBP0kw3o3tXX6qoydUWA",
        fit: BoxFit.cover,height: 190, width: double.infinity,),
          Row(children: [Text("소유 3대 몇?", style: TextStyle(fontSize: 18),)])],),
    );
  }
}
