import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/router/client.dart';

import '../../../domain/model/chord_block.dart';
import '../../../domain/model/play_option.dart';
import '../../../domain/model/sheet_element_size.dart';
import '../../../domain/model/sheet_info.dart';
import '../feedback_state.dart';
import '../sheet_state.dart';
import 'chord_block_state.dart';

class SheetViewModel {
  late final ValueNotifier<SheetState> _sheetState;
  late final ValueNotifier<FeedbackState> _feedbackState;
  late final ValueNotifier<PlayOption> _playOption;
  late final ValueNotifier<int> _playPosition;
  final List<ValueNotifier<ChordBlockState>> _chordBlockStates = [];

  ValueNotifier<SheetState> get sheetState => _sheetState;

  ValueNotifier<FeedbackState> get feedbackState => _feedbackState;

  ValueNotifier<PlayOption> get playOption => _playOption;

  ValueNotifier<int> get playPosition => _playPosition;

  List<ValueNotifier<ChordBlockState>> get chordBlockStates =>
      _chordBlockStates;

  SheetViewModel({
    required SheetState sheetState,
    required FeedbackState feedbackState,
    required PlayOption playOption,
    required int playPosition,
  }) {
    _sheetState.value = sheetState;
    _feedbackState.value = feedbackState;
    _playOption.value = playOption;
    _playPosition.value = playPosition;

    for (ChordBlock chordBlock in _sheetState.value.sheetData!.chords) {
      _chordBlockStates.add(ValueNotifier(ChordBlockState(
        beatAccuracy: null,
        chord: chordBlock.chord,
        startPositionInMillis: (chordBlock.start * 1000).toInt(),
        endPositionInMillis: (chordBlock.end * 1000).toInt(),
      )));
    }
  }
}
