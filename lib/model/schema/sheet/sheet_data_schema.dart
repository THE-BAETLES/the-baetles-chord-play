import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/schema.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/chord_info_schema.dart';

part 'sheet_data_schema.g.dart';

@JsonSerializable()
class SheetDataSchema{
  @JsonKey(name: '_id')
  String id;
  int bpm;

  @JsonKey(name: 'chord_infos')
  ChordInfoSchema chordInfos;

  SheetDataSchema(
      {required this.id, required this.bpm, required this.chordInfos});

  factory SheetDataSchema.fromJson(Map<String, dynamic> json) =>
      _$SheetDataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$SheetDataSchemaToJson(this);
}
