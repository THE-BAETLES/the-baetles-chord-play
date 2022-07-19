import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlowerPodImage extends StatelessWidget {
  const FlowerPodImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/images/img_flower_pod.svg");
  }
}