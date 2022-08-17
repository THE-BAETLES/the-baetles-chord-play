import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/schema.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/chord_info_schema.dart';

import '../../../domain/model/chord_block.dart';
import '../../../domain/model/sheet_data.dart';

part 'sheet_data_schema.g.dart';

@JsonSerializable()
class SheetDataSchema {
  @JsonKey(name: '_id')
  String id;
  int bpm;

  @JsonKey(name: 'chord_infos')
  List<ChordInfoSchema> chordInfos;

  SheetDataSchema(
      {required this.id, required this.bpm, required this.chordInfos});

  factory SheetDataSchema.fromJson(Map<String, dynamic> json) =>
      _$SheetDataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$SheetDataSchemaToJson(this);

  SheetData toChordData() {
    final List<ChordBlock> chordBlocks = [];

    for (ChordInfoSchema chordInfo in chordInfos) {
      chordBlocks.add(chordInfo.toChordBlock());
    }

    return SheetData(
      id: id,
      bpm: bpm as double,
      chords: chordBlocks,
    );
  }
}
