import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import '../domain/model/chord.dart';
import '../domain/model/note.dart';

class ChordPickerViewModel extends ChangeNotifier {
  final Function(Chord?) onChangeChord;
  Note? _selectedNote;
  TriadType? _selectedTriadType;

  Note? get selectedNote => _selectedNote;

  TriadType? get selectedTriadType => _selectedTriadType;

  ChordPickerViewModel({
    required this.onChangeChord,
    Note? initRoot,
    TriadType? initTriadType,
  }) {
    _selectedNote = initRoot;
    _selectedTriadType = initTriadType;
  }

  void onChangeRoot(Note? note) {
    _selectedNote = note;

    onChangeChord(_getChordFromNoteAndTriadType(
      _selectedNote,
      _selectedTriadType,
    ));

    notifyListeners();
  }

  void onChangeTriadType(TriadType? triadType) {
    _selectedTriadType = triadType;

    onChangeChord(_getChordFromNoteAndTriadType(
      _selectedNote,
      _selectedTriadType,
    ));

    notifyListeners();
  }

  Chord? _getChordFromNoteAndTriadType(Note? note, TriadType? triadType) {
    if (_selectedNote == null || _selectedTriadType == null) {
      return null;
    } else {
      return Chord(_selectedNote!, _selectedTriadType!);
    }
  }
}
