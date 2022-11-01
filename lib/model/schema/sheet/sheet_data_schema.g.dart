// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_data_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SheetDataSchema _$SheetDataSchemaFromJson(Map<String, dynamic> json) =>
    SheetDataSchema(
      id: json['_id'] as String,
      bpm: json['bpm'] as int,
      chords: (json['infos'] as List<dynamic>)
          .map((e) => ChordInfoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SheetDataSchemaToJson(SheetDataSchema instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'bpm': instance.bpm,
      'infos': instance.chords,
    };
