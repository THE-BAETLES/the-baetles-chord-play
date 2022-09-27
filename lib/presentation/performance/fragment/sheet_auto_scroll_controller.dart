import 'package:flutter/material.dart';

class SheetAutoScrollController extends ScrollController {
  static const animationDuration = Duration(milliseconds: 200);
  static const none = -1;

  int _priorLineIdx = none;

  SheetAutoScrollController({
    required double startPosition,
    required double lineHeight,
    required ValueNotifier<int> positionInMs,
  }) {
    positionInMs.addListener(() {
      int newLineIdx = positionInMs.value ~/ (16 * 1000);

      if (newLineIdx != _priorLineIdx) {
        super.animateTo(
          startPosition + newLineIdx * lineHeight,
          duration: animationDuration,
          curve: Curves.ease,
        );
      }

      _priorLineIdx = newLineIdx;
    });
  }
}
