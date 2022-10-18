import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import '../domain/model/chord.dart';
import '../domain/model/note.dart';

class ChordPickerViewModel extends ChangeNotifier {
  final Function(Chord?) onChangeChord;
  Note? _selectedNote;
  TriadType? _selectedTriadType;
  Note? _selectedBass;

  Note? get selectedNote => _selectedNote;

  TriadType? get selectedTriadType => _selectedTriadType;

  Note? get selectedBass => _selectedBass;

  ChordPickerViewModel({
    required this.onChangeChord,
    Note? initRoot,
    TriadType? initTriadType,
    Note? initBass,
  }) {
    _selectedNote = initRoot;
    _selectedTriadType = initTriadType;
    _selectedBass = initBass;
  }

  void onChangeRoot(Note? note) {
    if (note == null) {
      _selectedTriadType = null;
      _selectedBass = null;
    }

    _selectedNote = note;

    onChangeChord(_getChordFromFragment(
      _selectedNote,
      _selectedTriadType,
      _selectedBass,
    ));

    notifyListeners();
  }

  void onChangeTriadType(TriadType? triadType) {
    _selectedTriadType = triadType;

    onChangeChord(_getChordFromFragment(
      _selectedNote,
      _selectedTriadType,
      _selectedBass,
    ));

    notifyListeners();
  }

  void onChangeBass(Note? bass) {
    _selectedBass = bass;

    onChangeChord(_getChordFromFragment(
      _selectedNote,
      _selectedTriadType,
      _selectedBass,
    ));

    notifyListeners();
  }

  Chord? _getChordFromFragment(Note? note, TriadType? triadType, Note? bass) {
    if (_selectedNote == null || _selectedTriadType == null) {
      return null;
    } else {
      return Chord(_selectedNote!, _selectedTriadType!, bass);
    }
  }
}
