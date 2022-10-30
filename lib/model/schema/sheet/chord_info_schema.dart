import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/domain/model/note.dart';
import 'package:the_baetles_chord_play/domain/model/triad_type.dart';

import '../../../domain/model/chord.dart';
import '../../../domain/model/chord_block.dart';
import 'chord_schema.dart';

part 'chord_info_schema.g.dart';

@JsonSerializable()
class ChordInfoSchema {
  @JsonKey(name: "chord")
  ChordSchema chord;

  @JsonKey(name: "beat_time")
  double beatTime;

  ChordInfoSchema({
    required this.chord,
    required this.beatTime,
  });

  factory ChordInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$ChordInfoSchemaFromJson(json);

  factory ChordInfoSchema.fromChordBlock(ChordBlock chordBlock) {
    return ChordInfoSchema(
      chord: ChordSchema.fromChord(chordBlock.chord),
      beatTime: chordBlock.beatTime,
    );
  }

  Map<String, dynamic> toJson() => _$ChordInfoSchemaToJson(this);

  ChordBlock toChordBlock() {
    return ChordBlock(
      chord: chord.toChord(),
      beatTime: beatTime,
    );
  }
}
