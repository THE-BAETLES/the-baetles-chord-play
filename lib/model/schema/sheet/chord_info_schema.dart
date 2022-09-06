import 'package:json_annotation/json_annotation.dart';

import '../../../domain/model/chord.dart';
import '../../../domain/model/chord_block.dart';

part 'chord_info_schema.g.dart';

@JsonSerializable()
class ChordInfoSchema {
  String chord;
  double start;
  double end;
  int position;

  ChordInfoSchema(
      {required this.chord,
      required this.start,
      required this.end,
      required this.position});

  factory ChordInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$ChordInfoSchemaFromJson(json);

  factory ChordInfoSchema.fromChordBlock(ChordBlock chordBlock) {
    return ChordInfoSchema(
      chord: chordBlock.toString(),
      start: chordBlock.start,
      end: chordBlock.end,
      position: chordBlock.position,
    );
  }

  Map<String, dynamic> toJson() => _$ChordInfoSchemaToJson(this);

  ChordBlock toChordBlock() {
    List<String> splitString = chord.split(':');
    return ChordBlock(
      Chord.fromString("${splitString[0]}3:${splitString[1]}"),
      position,
      start,
      end,
    );
  }
}
