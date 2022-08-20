import 'dart:async';

import 'package:the_baetles_chord_play/domain/model/play_state.dart';
import 'package:the_baetles_chord_play/service/conductor/conductor_interface.dart';
import 'package:the_baetles_chord_play/service/conductor/performer_interface.dart';

import '../../../controller/pitch_tracker/pitch_tracker.dart';
import '../../../domain/model/chord.dart';
import '../../../domain/model/chord_block.dart';
import '../../../domain/model/note.dart';
import '../../../domain/model/sheet_data.dart';

class ChordChecker implements PerformerInterface {
  final PitchTracker _pitchTracker = PitchTracker();
  final SheetData _sheetData;

  ConductorInterface? _conductor;
  PlayState? _playState;
  Function(int)? _onCorrectCallback;

  ChordChecker(this._sheetData);

  @override
  Future<void> onAttachConductor(ConductorInterface conductor) async {
    _conductor = conductor;
    _conductor!.addCurrentPositionListener(_updatePlayState);
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

  @override
  Future<void> cancel() async {
    // TODO : write this method
  }

  @override
  Future<void> dispose() async {
    if (_pitchTracker.hasListener) {
      _pitchTracker.detachStreamListener();
    }

    _conductor!.removeCurrentPositionListener(_updatePlayState);
    _conductor = null;
    _playState = null;
  }

  void start() {
    _pitchTracker.attachStreamListener(_streamListenerCallback);
  }

  void pause() {
    _pitchTracker.detachStreamListener();
  }

  void setOnCorrectCallback(Function(int) callback) {
    _onCorrectCallback = callback;
  }

  void removeOnCorrectCallback() {
    _onCorrectCallback = null;
  }

  void _streamListenerCallback(List<Note> detectedNotes) {
    int currentPosition = (_playState!.currentPosition / 1000.0) ~/ _playState!.spb;

    if (_sheetData.chords.isEmpty ||
        _sheetData.chords.first.position > currentPosition) {
      return;
    }

    ChordBlock lastBlock = _sheetData.chords.lastWhere((chordBlock) {
      return chordBlock.position <= currentPosition;
    });

    if (currentPosition - lastBlock.position > _playState!.spb) {
      // 가장 최근의 코드가 이미 지나간 코드인 경우
      return;
    }

    List<Note> answer = lastBlock.chord.getNotes();

    if (detectedNotes.toSet().containsAll(answer)) {
      _onCorrectCallback?.call(currentPosition);
    } else {
      _onCorrectCallback?.call(currentPosition);
    }
  }

  void _updatePlayState(PlayState playState) {
    _playState = playState;
  }
}
