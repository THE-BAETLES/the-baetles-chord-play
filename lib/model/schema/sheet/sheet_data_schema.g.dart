// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_data_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SheetDataSchema _$SheetDataSchemaFromJson(Map<String, dynamic> json) =>
    SheetDataSchema(
      id: json['_id'] as String,
      bpm: json['bpm'] as int,
      chordInfos:
          ChordInfoSchema.fromJson(json['chord_infos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SheetDataSchemaToJson(SheetDataSchema instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'bpm': instance.bpm,
      'chord_infos': instance.chordInfos,
    };
