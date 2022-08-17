import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  final String thumbnailPath;
  final double width;
  final double height;

  const VideoThumbnail({
    Key? key,
    required this.thumbnailPath,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      thumbnailPath,
      width: width,
      height: height,
      color: Colors.grey,
    );
  }
}
