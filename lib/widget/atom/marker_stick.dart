import 'package:flutter/material.dart';

import 'app_colors.dart';

class MarkerStick extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  const MarkerStick({
    Key? key,
    this.color = AppColors.grayD2,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
