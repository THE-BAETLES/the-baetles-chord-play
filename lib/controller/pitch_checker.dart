import 'dart:collection';
import 'dart:math';
import 'dart:developer' as dev;

import 'detection_record_interface.dart';
import 'pitch_tracker/pitch_tracker.dart';

class PitchChecker implements DetectionRecordInterface {
  final PitchTracker _pitchTracker = PitchTracker();
  final Queue<Detection> detectionRecords = Queue<Detection>();
  final int recordMaxLength = 330;

  PitchChecker();

  void start() {
    _pitchTracker.attachStreamListener(_streamListenerCallback);
  }

  void pause() {
    _pitchTracker.detachStreamListener();
  }

  void _streamListenerCallback(int startedAt, List<List<int>> detectedPitches) {
    dev.log("PitchChecker: detected at ${startedAt}, ${detectedPitches}");
    int interval = 32; // milliseconds
    int initOffset = 0;

    if (detectionRecords.length != 0) {
      initOffset = max((((detectionRecords.last.detectedAt - startedAt) ~/ interval) + 1), 0);
    }
    // queue.last.detectedAt < startedAt + initOffset * interval
    // max((((queue.last.detectedAt - startedAt) / interval) + 1), 0)

    for (int offset = initOffset; offset < detectedPitches.length; ++offset) {
      int detectedAt = startedAt + offset * interval;
      detectionRecords.add(Detection(detectedAt, detectedPitches[offset].toSet()));
    }

    while(detectionRecords.length > recordMaxLength) {
      // 오래된 결과 제거 (FIFO)
      detectionRecords.removeFirst();
    }
  }

  @override
  bool isPitchExist(int start, int length, int pitch) {
    for (final detection in detectionRecords) {
      if (detection.detectedAt < start || start + length <= detection.detectedAt) {
        continue;
      }

      if (detection.pitches.contains(pitch)) {
        return true;
      }
    }

    return false;
  }
}

class Detection {
  final int detectedAt;
  final Set<int> pitches;

  Detection(this.detectedAt, this.pitches);
}