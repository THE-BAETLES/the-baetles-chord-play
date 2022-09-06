import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/create_sheet.dart';

class SheetCreationDialogViewModel extends ChangeNotifier {
  static final validTitleChars = RegExp(r"^[가-힣0-9a-zA-Z . ]+$");
  static final validBpmChars = RegExp(r"^[0-9.-.]+$");

  final List<Function(String, double)> onCompleteCallbacks = [];
  final List<Function()> onCancelCallbacks = [];

  String _inputTitle = "";
  String _inputBpm = "";

  bool _isTitleValid = true;
  bool _isBpmValid = true;

  String get inputTitle => _inputTitle;

  String get inputBpm => _inputBpm;

  bool get isTitleValid => _isTitleValid;

  bool get isBpmValid => _isBpmValid;

  void addOnCompleteCallback(Function(String, double) callback) {
    if (!onCompleteCallbacks.contains(callback)) {
      onCompleteCallbacks.add(callback);
    }
  }

  bool removeOnCompleteCallback(Function(String, double) callback) {
    bool isSuccessful = onCompleteCallbacks.remove(callback);
    return isSuccessful;
  }

  void addOnCancelCallback(Function() callback) {
    if (!onCancelCallbacks.contains(callback)) {
      onCancelCallbacks.add(callback);
    }
  }

  bool removeOnCancelCallback(Function() callback) {
    bool isSuccessful = onCancelCallbacks.remove(callback);
    return isSuccessful;
  }

  void onChangeTitle(String title) {
    _inputTitle = title;
    _isTitleValid = _checkTitleValid(title);

    notifyListeners();
  }

  void onChangeBpm(String bpm) {
    _inputBpm = bpm;
    _isBpmValid = _checkBpmValid(bpm);

    notifyListeners();
  }

  void onComplete() {
    String bpm = _inputBpm;
    String title = _inputTitle;

    if (!_checkBpmValid(bpm) || !_checkTitleValid(title)) {
      return;
    }

    for (Function(String, double) callback in onCompleteCallbacks) {
      callback(_inputTitle, double.parse(bpm));
    }
  }

  void onCancel() {
    reset();

    for (Function() callback in onCancelCallbacks) {
      callback();
    }
  }

  bool _checkTitleValid(String title) {
    bool isValid = title.isNotEmpty && title.length <= 15 && validTitleChars.hasMatch(title);
    return isValid;
  }

  bool _checkBpmValid(String bpm) {
    if (!(bpm.isNotEmpty && bpm.length <= 15 && validBpmChars.hasMatch(bpm))) {
      return false;
    }

    double? parsedBpm = double.tryParse(bpm);
    bool canBeParsed = parsedBpm != null;

    return canBeParsed;
  }

  void reset() {
    _inputTitle = "";
    _inputBpm = "";

    _isTitleValid = false;
    _isBpmValid = false;
  }
}