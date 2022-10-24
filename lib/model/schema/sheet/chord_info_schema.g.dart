// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord_info_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChordInfoSchema _$ChordInfoSchemaFromJson(Map<String, dynamic> json) =>
    ChordInfoSchema(
      root: json['root'] as String,
      triad: json['triad'] as String,
      bass: json['bass'] as String,
      beatTime: (json['beat_time'] as num).toDouble(),
    );

Map<String, dynamic> _$ChordInfoSchemaToJson(ChordInfoSchema instance) =>
    <String, dynamic>{
      'root': instance.root,
      'triad': instance.triad,
      'bass': instance.bass,
      'beat_time': instance.beatTime,
    };
