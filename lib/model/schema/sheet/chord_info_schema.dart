import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import '../../../domain/model/chord.dart';
import '../../../domain/model/chord_block.dart';

part 'chord_info_schema.g.dart';

@JsonSerializable()
class ChordInfoSchema {
  @JsonKey(name: "root")
  String root;

  @JsonKey(name: "triad")
  String triad;

  @JsonKey(name: "bass")
  String bass;

  @JsonKey(name: "beat_time")
  double beatTime;

  ChordInfoSchema({
    required this.root,
    required this.triad,
    required this.bass,
    required this.beatTime,
  });

  factory ChordInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$ChordInfoSchemaFromJson(json);

  factory ChordInfoSchema.fromChordBlock(ChordBlock chordBlock) {
    return ChordInfoSchema(
      root: chordBlock.chord?.root.noteNameWithoutOctave ?? "none",
      triad: chordBlock.chord?.triadType.notation ?? "none",
      bass: chordBlock.chord?.bass?.noteNameWithoutOctave ?? "none",
      beatTime: chordBlock.beatTime,
    );
  }

  Map<String, dynamic> toJson() => _$ChordInfoSchemaToJson(this);

  ChordBlock toChordBlock() {
    Note? bassNote;

    if (bass != "none") {
      Note.fromNoteName(bass!);
    }

    Chord? chord;

    if (root != "none") {
      chord = Chord(
        Note.fromNoteName(root),
        TriadType.tryParse(triad!)!,
        bassNote,
      );
    }

    return ChordBlock(
      chord: chord,
      beatTime: beatTime,
    );
  }
}
