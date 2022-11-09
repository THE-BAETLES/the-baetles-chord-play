import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';

import '../../../domain/model/chord.dart';
import 'beat_state.dart';

class BeatStates {
  static const none = -1;
  final List<ValueNotifier<BeatState>> states;
  final beatStateLock = Mutex();
  final ValueNotifier<int> _playingPosition = ValueNotifier(none);

  ValueNotifier<int> get playingPosition => _playingPosition;

  BeatState get playingBeatState => states[_playingPosition.value].value;

  BeatStates(this.states);

  setPlayingPosition(int position) async {
    if (_playingPosition.value == position) {
      return;
    }

    await beatStateLock.acquire();

    if (_playingPosition.value != none) {
      states[_playingPosition.value].value = BeatState(
        states[_playingPosition.value].value.chord,
        false,
      );
    }

    if (0 <= position && position < states.length) {
      states[position].value = BeatState(
        states[position].value.chord,
        true,
      );

      _playingPosition.value = position;
      _playingPosition.notifyListeners();
    }

    beatStateLock.release();
  }

  setChord(int position, Chord? chord) async {
    await beatStateLock.acquire();

    states[position].value = BeatState(
      chord,
      states[position].value.isPlaying,
    );

    beatStateLock.release();
  }
}
