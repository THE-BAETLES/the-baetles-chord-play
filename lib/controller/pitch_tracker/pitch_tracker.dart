import 'dart:async';

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
        .map((event) => event as List<int>);
  }

  void attachStreamListener(Function(List<Note>) callback) {
    _subscription = _pitchStream.listen((detectedPitches) {
      List<Note> detectedNotes = [];

      for (int pitch in detectedPitches) {
        detectedNotes.add(Note(pitch));
      }

      print(detectedPitches);
      callback(detectedNotes);
    });
  }

  void detachStreamListener() {
    _subscription?.cancel();
  }
}
