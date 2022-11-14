import 'package:the_baetles_chord_play/domain/model/finger.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';

class FingerPosition {
  static final openNotes = [
    Note.fromNoteName("E4"),
    Note.fromNoteName("B3"),
    Note.fromNoteName("G3"),
    Note.fromNoteName("D3"),
    Note.fromNoteName("A2"),
    Note.fromNoteName("E2"),
  ];

  final Finger? finger;
  final int stringNumber;
  final int fret;

  FingerPosition({
    required this.finger,
    required this.stringNumber,
    required this.fret,
  }) {
    assert (-1 <= fret);
    assert (1 <= stringNumber && stringNumber <= 6);
  }

  Note get note => Note.fromNoteNumber(openNotes[stringNumber - 1].noteNumber + fret);

  @override
  String toString() {
    return "finger: ${finger}, stringNumber: ${stringNumber}, fret: ${fret}, note: ${note.noteName}";
  }


}
