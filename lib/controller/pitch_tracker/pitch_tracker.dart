import 'dart:async';

import 'package:flutter/services.dart';

class PitchTracker {
  final _eventChannel =
      const EventChannel('site.baetles.chordplay/chord-detection');
  late final Stream _pitchStream;
  StreamSubscription? _subscription;

  bool get hasListener => _subscription != null;

  PitchTracker() {
    _pitchStream = _eventChannel.receiveBroadcastStream().map((event) => event as int);
  }

  void attachStreamListener(Function(int) callback) {
    _subscription = _pitchStream.listen((event) {
      callback(event);
    });
  }

  void detachStreamListener() {
    _subscription?.cancel();
  }
}
