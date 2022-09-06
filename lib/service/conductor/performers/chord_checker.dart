import 'dart:async';

import 'package:the_baetles_chord_play/domain/model/play_option.dart';
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
  PlayOption? _playOption;
  Function(int)? _onCorrectCallback;
  Function(int)? _onWrongCallback;
  int? _listeningPosition;
  int? _currentPosition;
  bool _isCurrentBeatCorrect = true;

  ChordChecker(this._sheetData);

  @override
  Future<void> onAttachConductor(ConductorInterface conductor) async {
    _conductor = conductor;
    _conductor!.addCurrentPositionListener(_updateCurrentPosition);
  }

  @override
  Future<bool> syncPlayOptionAndReady(PlayOption playState) async {
    _playOption = playState;

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

    _conductor!.removeCurrentPositionListener(_updateCurrentPosition);
    _conductor = null;
    _playOption = null;
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

  void setOnWrongCallback(Function(int) callback) {
    _onWrongCallback = callback;
  }

  void removeOnWrongCallback() {
    _onWrongCallback = null;
  }

  void _streamListenerCallback(List<Note> detectedNotes) {
    int currentPosition =
        (_currentPosition! / 1000.0) ~/ _playOption!.spb;

    if (_listeningPosition != currentPosition &&
        _listeningPosition != null &&
        !_isCurrentBeatCorrect) {
      _onWrongCallback?.call(_listeningPosition!);
      print("오답 : { index: ${_listeningPosition} }");
      _listeningPosition = null;
    }

    if (_sheetData.chords.isEmpty ||
        _sheetData.chords.first.position > currentPosition) {
      return;
    }

    ChordBlock lastBlock = _sheetData.chords.lastWhere((chordBlock) {
      return chordBlock.position <= currentPosition;
    });

    if (currentPosition - lastBlock.position >= 1) {
      // 가장 최근의 코드가 이미 지나간 코드인 경우
      return;
    }

    if (_listeningPosition != currentPosition) {
      _listeningPosition = currentPosition;
      _isCurrentBeatCorrect = false;
    }

    Set<int> simplifiedNotes =
        detectedNotes.map((note) => (note.keyNumber - 1) % 12 + 1).toSet();
    List<int> answer = lastBlock.chord
        .getNotes()
        .map((e) => (e.keyNumber - 1) % 12 + 1)
        .toList();

    bool isCorrect = true;

    for (int answerNote in answer) {
      if (!simplifiedNotes.contains(answerNote)) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      _isCurrentBeatCorrect = true;
      _onCorrectCallback?.call(currentPosition);
      print("정답 : { index: ${currentPosition} }");
    }
  }

  void _updateCurrentPosition(int currentPosition) {
    _currentPosition = currentPosition;
  }
}
