import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';

import '../../../domain/model/chord.dart';
import 'beat_state.dart';

class BeatStates {
  static const none = -1;
  final List<ValueNotifier<BeatState>> beatStates;
  final beatStateLock = Mutex();

  int _playingPosition = none;

  BeatStates(this.beatStates);

  setPlayingPosition(int position) async {
    if (_playingPosition == position) {
      return;
    }

    await beatStateLock.acquire();

    if (_playingPosition != none) {
      beatStates[_playingPosition].value = BeatState(
        beatStates[_playingPosition].value.chord,
        false,
      );
    }

    if (0 <= position && position < beatStates.length) {
      beatStates[position].value = BeatState(
        beatStates[position].value.chord,
        true,
      );
    }

    _playingPosition = position;

    beatStateLock.release();
  }

  setChord(int position, Chord? chord) async {
    await beatStateLock.acquire();

    beatStates[position].value = BeatState(
      chord,
      beatStates[position].value.isPlaying,
    );

    beatStateLock.release();
  }
}
