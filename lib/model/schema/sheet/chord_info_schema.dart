import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/schema.dart';

part 'chord_info_schema.g.dart';

@JsonSerializable()
class ChordInfoSchema{
  String chord;
  int start;
  int end;
  int position;

  ChordInfoSchema({required this.chord, required this.start,
  required this.end, required this.position});

  factory ChordInfoSchema.fromJson(Map<String, dynamic> json) =>
      _$ChordInfoSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$ChordInfoSchemaToJson(this);
}