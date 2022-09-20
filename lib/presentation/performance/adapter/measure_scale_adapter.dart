import 'package:flutter/src/gestures/scale.dart';
import 'package:the_baetles_chord_play/presentation/performance/adapter/scale_adapter.dart';

class MeasureScaleAdapter implements ScaleAdapter {
  static const lowerCriticalPoint = 0.7;
  static const upperCriticalPoint = 1.5;

  static const decreaseInclination = 0.15;
  static const increaseInclination = 0.3;

  static const minMeasureCount = 1;
  static const maxMeasureCount = 6;

  final int Function() getCurrentMeasureCount;
  final Function(int) onChangeMeasureCount;

  int? baseMeasureCount;

  MeasureScaleAdapter({
    required this.getCurrentMeasureCount,
    required this.onChangeMeasureCount,
  });

  @override
  void onScaleStart(ScaleStartDetails scaleStartDetails) {
    baseMeasureCount = getCurrentMeasureCount();
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails scaleUpdateDetails) {
    double scale = scaleUpdateDetails.scale;

    if (scale < lowerCriticalPoint) {
      onChangeMeasureCount.call(
        (baseMeasureCount! + (lowerCriticalPoint - scale) ~/ decreaseInclination).clamp(
          minMeasureCount,
          maxMeasureCount,
        ),
      );
    } else if (scale > upperCriticalPoint) {
      onChangeMeasureCount.call(
        (baseMeasureCount! - (scale - upperCriticalPoint) ~/ increaseInclination).clamp(
          minMeasureCount,
          maxMeasureCount,
        ),
      );
    }
  }

  @override
  void onScaleEnd(ScaleEndDetails scaleEndDetails) {
    baseMeasureCount = null;
  }
}
