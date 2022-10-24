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

  @JsonKey(name: 'bpm')
  int bpm;

  @JsonKey(name: 'infos')
  List<ChordInfoSchema> chords;

  SheetDataSchema({
    required this.id,
    required this.bpm,
    required this.chords,
  });

  factory SheetDataSchema.fromJson(Map<String, dynamic> json) =>
      _$SheetDataSchemaFromJson(json);

  factory SheetDataSchema.fromSheetData(SheetData sheetData) {
    return SheetDataSchema(
      id: sheetData.id,
      bpm: (sheetData.bpm).toInt(),
      chords: sheetData.chords.map((e) {
        return ChordInfoSchema.fromChordBlock(e);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => _$SheetDataSchemaToJson(this);

  SheetData toSheetData() {
    final List<ChordBlock> chordBlocks = [];

    for (ChordInfoSchema chordInfo in chords) {
      chordBlocks.add(chordInfo.toChordBlock());
    }

    return SheetData(
      id: id,
      bpm: bpm.toDouble(),
      chords: chordBlocks,
    );
  }
}
