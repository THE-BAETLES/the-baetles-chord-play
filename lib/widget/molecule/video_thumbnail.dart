import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'duration_badge.dart';

class VideoThumbnail extends StatelessWidget {
  final String thumbnailPath;
  final double width;
  final double height;
  final int? length;
  final BoxFit fit;

  const VideoThumbnail({
    Key? key,
    required this.thumbnailPath,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Image.network(
            thumbnailPath,
            width: width,
            height: height,
            fit: fit,
          ),
        ),
        Builder(builder: (context) {
          if (length == null) {
            return Container();
          }

          return Positioned(
            bottom: 4,
            right: 4,
            child: DurationBadge(
              duration: Duration(milliseconds: length!),
            ),
          );
        }),
      ],
    );
  }
}
