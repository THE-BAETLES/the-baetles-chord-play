// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChordSchema _$ChordSchemaFromJson(Map<String, dynamic> json) => ChordSchema(
      root: json['root'] as String,
      triad: json['triad'] as String,
      bass: json['bass'] as String,
    );

Map<String, dynamic> _$ChordSchemaToJson(ChordSchema instance) =>
    <String, dynamic>{
      'root': instance.root,
      'triad': instance.triad,
      'bass': instance.bass,
    };
