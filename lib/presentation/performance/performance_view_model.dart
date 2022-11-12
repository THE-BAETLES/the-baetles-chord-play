import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/controller/chord_checker.dart';
import 'package:the_baetles_chord_play/controller/chord_picker_view_model.dart';
import 'package:the_baetles_chord_play/domain/model/chord_block.dart';
import 'package:the_baetles_chord_play/domain/model/play_option.dart';
import 'package:the_baetles_chord_play/domain/use_case/add_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_user_id.dart';
import 'package:the_baetles_chord_play/domain/use_case/patch_sheet_data.dart';
import 'package:the_baetles_chord_play/domain/use_case/remove_conductor_position_listener.dart';
import 'package:the_baetles_chord_play/domain/use_case/set_youtube_player_controller.dart';
import 'package:the_baetles_chord_play/presentation/performance/state/beat_state.dart';
import 'package:the_baetles_chord_play/presentation/performance/state/beat_states.dart';
import 'package:the_baetles_chord_play/presentation/performance/state/sheet_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:the_baetles_chord_play/domain/model/fingering_feedback.dart';
import 'package:tuple/tuple.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/fingering.dart';
import '../../domain/model/loop.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../domain/model/video.dart';
import '../../domain/use_case/add_performer.dart';
import '../../domain/use_case/edit_sheet.dart';
import '../../domain/use_case/move_play_position.dart';
import '../../domain/use_case/update_play_option.dart';
import '../../service/conductor/performers/call_performer.dart';
import '../../controller/pitch_checker.dart';
import 'adapter/measure_scale_adapter.dart';
import 'adapter/scale_adapter.dart';
import 'state/feedback_state.dart';

class PerformanceViewModel with ChangeNotifier {
  final PlayOption initPlayOption = PlayOption(
    isPlaying: false,
    tempo: 1.0,
    defaultBpm: 80,
    loop: Loop.infinite(),
    capo: 0,
  );
  late final ValueNotifier<PlayOption> _playOption;
  final ValueNotifier<int> _currentPosition = ValueNotifier(0); // in mSec
  final ValueNotifier<bool> _isPitchBeingChecked = ValueNotifier(false);
  final ValueNotifier<bool> _isMuted = ValueNotifier(false);
  final ValueNotifier<FeedbackState> _feedbackState =
      ValueNotifier(FeedbackState());
  final ValueNotifier<SheetState?> _sheetState = ValueNotifier(null);
  final ValueNotifier<int?> _editingPosition = ValueNotifier(null);
  final ValueNotifier<Chord?> _selectedChord = ValueNotifier(null);
  final ValueNotifier<YoutubePlayerController?> _youtubeController =
      ValueNotifier(null);
  final ValueNotifier<int> _measureCount = ValueNotifier(4);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isTabVisible = ValueNotifier(false);
  final ValueNotifier<BeatStates> _beatStates = ValueNotifier(BeatStates([]));

  late final Function(int) _conductorPositionCallback;

  final AddPerformer _addPerformer;
  final UpdatePlayOption _updatePlayOption;
  final SetPlayPosition _setPlayPosition;
  final AddConductorPositionListener _addConductorPositionListener;
  final RemoveConductorPositionListener _removeConductorPositionListener;
  final SetYoutubePlayerController _setYoutubePlayerController;
  final EditSheet _editSheet;
  final GetUserId _getUserId;

  late final MeasureScaleAdapter _scaleAdapter;
  late final ChordPickerViewModel _chordPickerViewModel;

  final PlayOptionCallbackPerformer _callbackPerformer =
      PlayOptionCallbackPerformer();
  ChordChecker? _chordChecker;
  Video? _video;
  String? _userId;

  ValueNotifier<PlayOption> get playOption => _playOption;

  ValueNotifier<int> get currentPosition => _currentPosition;

  ValueNotifier<bool> get isMuted => _isMuted;

  ValueNotifier<bool> get isPitchBeingChecked => _isPitchBeingChecked;

  ValueNotifier<int?> get editingPosition => _editingPosition;

  ValueNotifier<SheetState?> get sheetState => _sheetState;

  ValueNotifier<int> get measureCount => _measureCount;

  ValueNotifier<bool> get isLoading => _isLoading;

  ValueNotifier<BeatStates> get beatStates => _beatStates;

  ValueNotifier<bool> get isTabVisible => _isTabVisible;

  bool get isEditing => _editingPosition.value != null;

  Chord? get editedChord {
    if (_editingPosition.value == null) {
      return null;
    }

    return _sheetState.value?.sheetData.chords[_editingPosition.value!].chord;
  }

  ValueNotifier<YoutubePlayerController?> get youtubePlayerController =>
      _youtubeController;

  ChordPickerViewModel get chordPickerViewModel => _chordPickerViewModel;

  ValueNotifier<FeedbackState> get feedbackState => _feedbackState;

  double? get currentPositionInPercentage {
    if (_video == null) {
      return null;
    }

    return currentPosition.value.toDouble() / _video!.length.toDouble() * 100.0;
  }

  ScaleAdapter get scaleAdapter => _scaleAdapter;

  PerformanceViewModel(
    this._updatePlayOption,
    this._setPlayPosition,
    this._addPerformer,
    this._addConductorPositionListener,
    this._removeConductorPositionListener,
    this._setYoutubePlayerController,
    this._editSheet,
    this._getUserId,
  ) {
    _conductorPositionCallback = ((int positionInMillis) {
      _currentPosition.value = positionInMillis;

      int playingIndex =
          _sheetState.value!.sheetData.chords.indexWhere((chord) {
        return positionInMillis < chord.beatTime * 1000;
      });

      _beatStates.value.setPlayingPosition(playingIndex);
      notifyListeners();
    });

    _playOption = ValueNotifier(initPlayOption);

    _chordPickerViewModel = ChordPickerViewModel(onChangeChord: onChangeChord);

    _scaleAdapter = MeasureScaleAdapter(
      getCurrentMeasureCount: () => _measureCount.value,
      onChangeMeasureCount: onChangeMeasureCount,
    );
  }

  void initViewModel({
    required final Video video,
    required final SheetInfo sheetInfo,
    required final SheetData sheetData,
  }) async {
    _video = video;

    _feedbackState.value = FeedbackState();
    _measureCount.value = 4;

    _playOption.value = PlayOption(
      isPlaying: false,
      tempo: 1.0,
      defaultBpm: sheetData.bpm,
      loop: Loop.infinite(),
      capo: 0,
    );

    _sheetState.addListener(() {
      _beatStates.value = _sheetStateToBeatStates(sheetState.value!);
    });

    _sheetState.value = SheetState(
      sheetInfo: sheetInfo,
      sheetData: sheetData,
    );

    _youtubeController.value = YoutubePlayerController(
      initialVideoId: video.id,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
        hideControls: true,
        mute: isMuted.value,
      ),
    );

    _setYoutubePlayerController(_youtubeController.value!);

    _setPlayPosition(position: 0);

    _updatePlayOption(
      isPlaying: _playOption.value.isPlaying,
      tempo: _playOption.value.tempo,
      defaultBpm: _playOption.value.defaultBpm,
      loop: _playOption.value.loop,
      capo: _playOption.value.capo,
    );

    _callbackPerformer.setCallback((PlayOption playOption) {
      _playOption.value = playOption;
      notifyListeners();
    });

    _addPerformer(_callbackPerformer);

    _chordChecker = ChordChecker();

    beatStates.value.playingPosition.addListener(() {
      if (!_isPitchBeingChecked.value) {
        return;
      }

      const int interval = 1500;
      const int waitTime = 300;
      const int compensation = 300;
      final int currentTime = DateTime.now().millisecondsSinceEpoch - compensation;
      final int endTime = currentTime + interval;
      final int playingPosition = beatStates.value.playingPosition.value;
      final Chord? chord = beatStates.value.playingBeatState.chord;

      if (chord != null && playOption.value.isPlaying) {
        Timer(const Duration(milliseconds: interval + waitTime), () {
          Tuple3<bool, Fingering?, List<int>> checkResult =
              _chordChecker!.isChordExist(currentTime, endTime, chord);
          final bool isChordDetected = checkResult.item1;
          final Fingering? answer = checkResult.item2;
          final List<int> wrongStrings = checkResult.item3;

          if (answer == null) {
            return;
          }

          log("${currentTime}~${endTime} ${playingPosition} | ${chord.fullName} ${isChordDetected ? "detected" : "not detected"}");

          _feedbackState.value.addMarkedIndex(playingPosition, isChordDetected);

          if (!isChordDetected) {
            _feedbackState.value.addFeedback(FingeringFeedback(
              beatIndex: playingPosition,
              answer: answer,
              wrongStringNumbers: wrongStrings,
            ));
          }

          _feedbackState.notifyListeners();
        });
      }
    });

    _addConductorPositionListener(_conductorPositionCallback);

    _initLoadingNotifier();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });

    _userId = await _getUserId();
  }

  void play() {
    _updatePlayOption(isPlaying: true);
  }

  void stop() {
    _updatePlayOption(isPlaying: false);
  }

  void moveTileIndex(int amount) {
    int destIdx = math.max(0, beatStates.value.playingPosition.value + amount);
    int destPosition = 0;

    if (destIdx > 0) {
      destPosition =
          _sheetState.value!.sheetData.chords[destIdx - 1].beatTimeInMillis;
    }

    _setPlayPosition(position: destPosition);
  }

  void onTileClicked(int tileIndex) {
    List<ChordBlock> chords = _sheetState.value!.sheetData.chords;

    if (tileIndex >= chords.length) {
      return;
    }

    int beatStartTimeInMillis = 0;

    if (tileIndex > 0) {
      beatStartTimeInMillis =
          (chords[tileIndex - 1].beatTime * 1000 + 1).toInt();
    }

    _setPlayPosition(position: beatStartTimeInMillis);
  }

  void onTileLongClicked(int tileIndex) async {
    if (_userId == null || _userId != _sheetState.value!.sheetInfo.userId) {
      return;
    }

    _editingPosition.value = tileIndex;
    List<ChordBlock>? chords = _sheetState.value?.sheetData.chords;

    if (tileIndex < 0 || chords == null || chords.length <= tileIndex) {
      _selectedChord.value = null;
    } else {
      _selectedChord.value = chords[tileIndex].chord;
    }

    notifyListeners();
  }

  void reset() {
    _removeConductorPositionListener(_conductorPositionCallback);
    _updatePlayOption(
      isPlaying: initPlayOption.isPlaying,
      tempo: initPlayOption.tempo,
      defaultBpm: initPlayOption.defaultBpm,
      loop: initPlayOption.loop,
      capo: initPlayOption.capo,
    );
    _youtubeController.value = null;
    _chordChecker?.pause();
    _isPitchBeingChecked.value = false;
    _isMuted.value = false;
    _editingPosition.value = null;
    _userId == null;
  }

  void onCheckButtonClicked() {
    _isPitchBeingChecked.value = !_isPitchBeingChecked.value;

    if (_isPitchBeingChecked.value) {
      _chordChecker?.start();
    } else {
      _chordChecker?.pause();
    }

    notifyListeners();
  }

  void onMuteButtonClicked() {
    _isMuted.value = !_isMuted.value;

    if (_isMuted.value) {
      youtubePlayerController.value?.mute();
    } else {
      youtubePlayerController.value?.unMute();
    }

    notifyListeners();
  }

  void onRepeatButtonClicked() {
    if (_playOption.value.loop.isInfinite()) {
      _updatePlayOption(loop: Loop(0, _video!.length));
    } else {
      _updatePlayOption(loop: Loop.infinite());
    }
  }

  void onChangeTempo(double tempo) {
    _updatePlayOption(
      tempo: tempo,
    );

    log("tempo changed to $tempo");
  }

  Future<void> onRemoveChordButtonClicked() async {
    SheetData newSheetData = await _editSheet(
      sheetId: _sheetState.value!.sheetInfo.id,
      sheet: _sheetState.value!.sheetData,
      position: _editingPosition.value!,
      newChord: null,
    );

    _sheetState.value = _sheetState.value!.copy(sheetData: newSheetData);

    _sheetState.notifyListeners();

    _editingPosition.value = null;
    _selectedChord.value = null;
  }

  void onCancelEdit() {
    _editingPosition.value = null;
    _selectedChord.value = null;
  }

  void onChangeChord(Chord? chord) {
    _selectedChord.value = chord;
  }

  void onApplyEdit() async {
    SheetData newSheetData = await _editSheet(
      sheetId: _sheetState.value!.sheetInfo.id,
      sheet: _sheetState.value!.sheetData,
      position: _editingPosition.value!,
      newChord: _selectedChord.value!,
    );

    _sheetState.value = _sheetState.value!.copy(sheetData: newSheetData);

    _sheetState.notifyListeners();

    _editingPosition.value = null;
    _selectedChord.value = null;
  }

  void onChangeMeasureCount(int measureCount) {
    if (kDebugMode) {
      assert(0 < measureCount);
    }

    this.measureCount.value = measureCount;
  }

  void onSetTabVisibility(bool isVisible) {
    isTabVisible.value = isVisible;
  }

  void _initLoadingNotifier() {
    _playOption.addListener(() {
      _updateIsLoading();
    });

    _youtubeController.value!.addListener(() {
      _updateIsLoading();
    });
  }

  void _updateIsLoading() {
    _isLoading.value = _playOption.value.isPlaying &&
        (_youtubeController.value != null) &&
        !(_youtubeController.value!.value.isPlaying);
  }

  BeatStates _sheetStateToBeatStates(SheetState sheetState) {
    final chords = sheetState.sheetData.chords;
    final List<ValueNotifier<BeatState>> beatStates = [];

    for (ChordBlock chordBlock in chords) {
      beatStates.add(ValueNotifier(BeatState(chordBlock.chord, false)));
    }

    return BeatStates(beatStates);
  }
}
