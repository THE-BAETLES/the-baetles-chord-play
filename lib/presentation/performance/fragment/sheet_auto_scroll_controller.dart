

import 'package:flutter/material.dart';

class SheetAutoScrollController extends ScrollController {
  static const animationDuration = Duration(milliseconds: 200);
  static const none = -1;
  static const defaultTopMargin = 30;
  static const beatPerMeasure = 4;

  int _priorLineIdx = none;
  late void Function() _positionChangeListener;
  late ValueNotifier<int> _positionInMs;

  SheetAutoScrollController({
    required double topMargin,
    required double bottomMargin,
    required double lineHeight,
    required int lineCount,
    required int measureCount,
    required int msPerBeat,
    required double screenHeight,
    required ValueNotifier<int> positionInMs,
  }) {
    _positionInMs = positionInMs;
    int msPerRow = measureCount * beatPerMeasure * msPerBeat;
    double sheetHeight = topMargin + lineHeight * lineCount + bottomMargin;

    _positionChangeListener = () {
      int newLineIdx = positionInMs.value ~/ msPerRow;

      if (newLineIdx != _priorLineIdx) {
        double newPosition =
            topMargin + newLineIdx * lineHeight - defaultTopMargin;

        if (newPosition <= sheetHeight - screenHeight) {
          try {
            super.animateTo(
              newPosition,
              duration: animationDuration,
              curve: Curves.ease,
            );
          } catch(e) {
            print(e);
            removeListener(_positionChangeListener);
          }
        }
      }

      _priorLineIdx = newLineIdx;
    };

    positionInMs.addListener(_positionChangeListener);
  }


  @override
  void dispose() {
    _positionInMs.removeListener(_positionChangeListener);
    super.dispose();
  }
}
