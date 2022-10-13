import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widget/atom/app_colors.dart';

class ZoomButton extends StatelessWidget {
  final double width;
  final double height;
  final Function()? onZoomIn;
  final Function()? onZoomOut;

  const ZoomButton({
    Key? key,
    required this.width,
    required this.height,
    this.onZoomIn,
    this.onZoomOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonSize = min(width / 2, height);

    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
          width: width,
          height: height,
          color: AppColors.grayF5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button(
                iconPath: "assets/icons/ic_minus.svg",
                width: buttonSize,
                height: buttonSize,
                onClick: () {
                  onZoomOut?.call();
                },
              ),
              Container(
                height: height,
                color: Colors.transparent,
                width: 1.5,
              ),
              _button(
                iconPath: "assets/icons/ic_plus.svg",
                width: buttonSize,
                height: buttonSize,
                onClick: () {
                  onZoomIn?.call();
                },
              ),
            ],
          )),
    );
  }

  Widget _button({
    required String iconPath,
    required double width,
    required double height,
    Function()? onClick,
  }) {
    return GestureDetector(
        onTap: onClick,
        child: Container(
          width: width,
          height: height,
          // color: AppColors.grayF0,
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset(
            color: AppColors.black04,
            iconPath,
          ),
        ),
    );
  }
}
