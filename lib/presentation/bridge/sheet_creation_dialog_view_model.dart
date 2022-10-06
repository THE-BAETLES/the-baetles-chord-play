import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/create_sheet_duplication.dart';

class SheetCreationDialogViewModel extends ChangeNotifier {
  static final validTitleChars = RegExp(r"^[가-힣0-9a-zA-Z . ]+$");

  final List<Function(String)> onCompleteCallbacks = [];
  final List<Function()> onCancelCallbacks = [];

  String _inputTitle = "";

  bool _isTitleValid = true;

  String get inputTitle => _inputTitle;

  bool get isTitleValid => _isTitleValid;

  void addOnCompleteCallback(Function(String) callback) {
    if (!onCompleteCallbacks.contains(callback)) {
      onCompleteCallbacks.add(callback);
    }
  }

  bool removeOnCompleteCallback(Function(String) callback) {
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

  void onComplete() {
    String title = _inputTitle;

    if (!_checkTitleValid(title)) {
      return;
    }

    for (Function(String) callback in onCompleteCallbacks) {
      callback(_inputTitle);
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

  void reset() {
    _inputTitle = "";

    _isTitleValid = false;
  }
}