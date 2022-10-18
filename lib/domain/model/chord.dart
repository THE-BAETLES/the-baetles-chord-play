import 'package:flutter/foundation.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import 'note.dart';

class Chord {
  final Note root;
  final TriadType triadType;
  final Note? bass;

  Chord(this.root, this.triadType, this.bass);

  String get chordName {
    return '${root.rootName}${triadType.notation}';
  }

  String get fullName {
    if (bass == null) {
      return '${root.noteName}:${triadType.notation}';
    } else {
      return '${root.noteName}:${triadType.notation}:${bass!.noteName}';
    }
  }

  factory Chord.fromString(String chord) {
    List<String> splitString = chord.split(":");
    Note root = Note.fromNoteName(splitString[0]);
    TriadType triadType = TriadType.values
        .singleWhere((triad) => triad.notation == splitString[1]);

    Note? bass;

    if (splitString.length == 3 && splitString[2] != "") {
      bass = Note.fromNoteName(splitString[2]);
    }

    return Chord(root, triadType, bass);
  }

  @override
  String toString() {
    String rootString = root.toString();
    String result =
        '${rootString.substring(0, rootString.length - 1)}:${triadType.notation}:${bass?.toString()}';
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chord &&
          runtimeType == other.runtimeType &&
          root == other.root &&
          triadType == other.triadType &&
          bass == other.bass;

  @override
  int get hashCode {
    return root.hashCode ^ triadType.hashCode ^ (bass != null ? bass!.hashCode : 0);
  }

  List<Note> getNotes() {
    switch (triadType) {
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
