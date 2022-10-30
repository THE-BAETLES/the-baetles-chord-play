// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord_info_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChordInfoSchema _$ChordInfoSchemaFromJson(Map<String, dynamic> json) =>
    ChordInfoSchema(
      chord: ChordSchema.fromJson(json['chord'] as Map<String, dynamic>),
      beatTime: (json['beat_time'] as num).toDouble(),
    );

Map<String, dynamic> _$ChordInfoSchemaToJson(ChordInfoSchema instance) =>
    <String, dynamic>{
      'chord': instance.chord,
      'beat_time': instance.beatTime,
    };
