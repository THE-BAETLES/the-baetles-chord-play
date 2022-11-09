import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';

import '../../domain/model/note.dart';

class PitchTracker {
  final _eventChannel =
      const EventChannel('site.baetles.chordplay/chord-detection');
  late final Stream _pitchStream;
  StreamSubscription? _subscription;

  bool get hasListener => _subscription != null;

  PitchTracker() {
    _pitchStream = _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as String);
  }

  void attachStreamListener(Function(int, List<List<int>>) callback) {
    _subscription = _pitchStream.listen((json) {
      final Map<String, dynamic> jsonData = jsonDecode(json);

      final recognized = jsonData['recognized'] as int;
      final List<dynamic> detectedPitches = jsonData['pitches'] as List<dynamic>;

      final List<List<int>> detectionResult = [];

      for (dynamic pitches in detectedPitches) {
        final List<int> temp = [];

        for (dynamic pitch in pitches as List<dynamic>) {
          temp.add(pitch);
        }

        detectionResult.add(temp);
      }

      callback(recognized - 1000, detectionResult);
    });
  }

  void detachStreamListener() {
    _subscription?.cancel();
  }
}