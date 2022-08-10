import 'package:flutter/material.dart';

import 'app_colors.dart';

class MarkerStick extends StatelessWidget {
  final Color color;

  const MarkerStick({Key? key, this.color = AppColors.grayD2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 26,
      color: color,
    );
  }
}
