import 'package:flutter/foundation.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import 'note.dart';

class Chord {
  final Note root;
  final TriadType triadType;

  Chord(this.root, this.triadType);

  String get chordName {
    return '${root.rootName}${triadType.notation}';
  }

  factory Chord.fromString(String chord) {
    List<String> splitString = chord.split(":");
    Note root = Note.fromNoteName(splitString[0]);
    TriadType triadType = TriadType.values
        .singleWhere((triad) => triad.notation == splitString[1]);

    return Chord(root, triadType);
  }

  @override
  String toString() {
    String rootString = root.toString();
    String result =
        '${rootString.substring(0, rootString.length - 1)}:${triadType.notation}';
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chord &&
          runtimeType == other.runtimeType &&
          root == other.root &&
          triadType == other.triadType;

  @override
  int get hashCode => root.hashCode ^ triadType.hashCode;

  List<Note> getNotes() {
    switch (this.triadType) {
      case TriadType.major:
        return [root, Note(root.keyNumber + 4), Note(root.keyNumber + 7)];
      case TriadType.minor:
        return [root, Note(root.keyNumber + 3), Note(root.keyNumber + 7)];
      default:
        if (kDebugMode) {
          print("warning! undefined triadType for method 'getNotes'");
        }
        return [root];
    }
  }
}
