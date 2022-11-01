import 'package:json_annotation/json_annotation.dart';

import '../../../domain/model/chord.dart';
import '../../../domain/model/note.dart';
import '../../../domain/model/triad_type.dart';

part 'chord_schema.g.dart';

@JsonSerializable()
class ChordSchema {
  @JsonKey(name: "root")
  String root;

  @JsonKey(name: "triad")
  String triad;

  @JsonKey(name: "bass")
  String bass;

  ChordSchema({
    required this.root,
    required this.triad,
    required this.bass,
  });

  factory ChordSchema.fromJson(Map<String, dynamic> json) =>
      _$ChordSchemaFromJson(json);

  factory ChordSchema.fromChord(Chord? chord) {
    return ChordSchema(
        root: chord?.root.noteNameWithoutOctave ?? "none",
        triad: chord?.triadType.notation ?? "none",
        bass: chord?.bass?.noteNameWithoutOctave ?? "none");
  }

  Map<String, dynamic> toJson() => _$ChordSchemaToJson(this);

  Chord? toChord() {
    if (root == "none") {
      return null;
    }

    Note? bassNote;

    if (bass != "none") {
      bassNote = Note.fromNoteName(bass!);
    }

    return Chord(
      Note.fromNoteName(root),
      TriadType.tryParse(triad!)!,
      bassNote,
    );
  }
}
