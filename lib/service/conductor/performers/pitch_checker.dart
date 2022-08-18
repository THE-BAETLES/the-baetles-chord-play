import 'dart:async';

import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../../controller/pitch_tracker/pitch_tracker.dart';

class PitchChecker implements PerformerInterface {
  final PitchTracker _pitchTracker = PitchTracker();

  @override
  Future<void> cancel() async {
    // TODO : write this method
  }

  @override
  Future<void> dispose() async {
    if (_pitchTracker.hasListener) {
      _pitchTracker.detachStreamListener();
    }
  }

  @override
  Future<void> onAttachConductor(ConductorInterface conductor) async {
    // nothing
  }

  @override
  Future<bool> syncPlayStateAndReady(PlayState playState) async {
    if (playState.isPlaying && !_pitchTracker.hasListener) {
      start();
    } else if (!playState.isPlaying && _pitchTracker.hasListener) {
      pause();
    }

    return true;
  }

  void start() {
    _pitchTracker.attachStreamListener(_streamListenerCallback);
  }

  void pause() {
    _pitchTracker.detachStreamListener();
  }

  void _streamListenerCallback(int event) {
    print("pitch tracker: $event");
  }
}