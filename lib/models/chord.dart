import 'package:the_baetles_chord_play/models/triad_type.dart';

import 'note.dart';

class Chord {
  final Note root;
  final TriadType triadType;

  Chord(this.root, this.triadType);

  String get chordName {
    return '${root.rootName}${triadType.notation}';
  }
}