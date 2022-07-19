import 'package:flutter/material.dart';

import '../atom/flower_pod_image.dart';
import '../atom/guitarist_image.dart';

class GuitaristPodImage extends StatelessWidget {
  const GuitaristPodImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        GuitaristImage(),
        FlowerPodImage(),
      ],
    );
  }
}