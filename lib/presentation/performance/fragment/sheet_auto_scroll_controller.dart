import 'dart:math';

import 'package:flutter/material.dart';

class SheetAutoScrollController extends ScrollController {
  static const animationDuration = Duration(milliseconds: 200);
  static const none = -1;
  static const additionalTopMargin = 30;
  static const beatPerMeasure = 4;

  int _priorLineIdx = none;
  late void Function() _positionChangeListener;
  late ValueNotifier<int> _playingPosition;

  SheetAutoScrollController({
    required ValueNotifier<int> playingPosition,
    required double topMargin,
    required double bottomMargin,
    required int beatPerLine,
    required double lineHeight,
    required int lineCount,
    required double screenHeight,
  }) {
    _playingPosition = playingPosition;
    double sheetHeight = topMargin + lineHeight * lineCount + bottomMargin;
    double maxPosition = sheetHeight - screenHeight;

    _positionChangeListener = () {
      int newLineIdx = _playingPosition.value ~/ beatPerLine;

      if (newLineIdx == _priorLineIdx) {
        return;
      }

      double newPosition = min(
        topMargin + newLineIdx * lineHeight - additionalTopMargin,
        maxPosition,
      );

      try {
        super.animateTo(
          newPosition,
          duration: animationDuration,
          curve: Curves.ease,
        );
      } catch (e) {
        print(e);
        removeListener(_positionChangeListener);
      }

      _priorLineIdx = newLineIdx;
    };

    playingPosition.addListener(_positionChangeListener);
  }

  @override
  void dispose() {
    _playingPosition.removeListener(_positionChangeListener);
    super.dispose();
  }
}
