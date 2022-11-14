import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';

import '../../../domain/model/chord.dart';
import 'beat_state.dart';

class BeatStates {
  static const none = -1;

  final List<ValueNotifier<BeatState>> states;
  final beatStateLock = Mutex();
  final ValueNotifier<int> _playingPosition = ValueNotifier(none);

  int _intercept = 0;

  int get intercept => _intercept;

  ValueNotifier<int> get playingPosition => _playingPosition;

  BeatState get playingBeatState => states[_playingPosition.value].value;

  BeatStates(this.states, {int intercept = 0}) {
    setIntercept(intercept);
  }

  setPlayingPosition(int position) async {
    if (_playingPosition.value == position) {
      return;
    }

    try {
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
      }
    } finally {
      beatStateLock.release();
    }
  }

  setChord(int position, Chord? chord) async {
    try {
      await beatStateLock.acquire();

      if (chord == null) {
        states[position].value = BeatState(
          chord,
          states[position].value.isPlaying,
        );
      } else {
        states[position].value = BeatState(
          _applyIntercept(chord, _intercept),
          states[position].value.isPlaying,
        );
      }
    } finally {
      beatStateLock.release();
    }
  }

  Future<void> setIntercept(int newIntercept) async {
    if (_intercept == newIntercept) {
      return;
    }

    try {
      await beatStateLock.acquire();

      int diff = newIntercept - _intercept;
      _intercept = newIntercept;

      for (final state in states) {
        if (state.value.chord == null) {
          continue;
        }

        state.value = BeatState(
          _applyIntercept(state.value.chord!, diff),
          state.value.isPlaying,
        );
      }
    } finally {
      beatStateLock.release();
    }
  }

  Chord _applyIntercept(Chord chord, int intercept) {
    return chord.copy(
      root: Note(chord.root.keyNumber + intercept),
      bass: null,
    );
  }
}
