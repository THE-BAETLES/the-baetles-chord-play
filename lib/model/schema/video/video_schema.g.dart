// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoSchema _$VideoSchemaFromJson(Map<String, dynamic> json) => VideoSchema(
      id: json['_id'] as String,
      thumbnailPath: json['thumbnail_path'] as String,
      title: json['title'] as String,
      genre: json['genre'] as String,
      singer: json['singer'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      length: json['length'] as int,
      difficultyAvg: json['difficultyAvg'] as int,
      playCount: json['play_count'] as int,
    );

Map<String, dynamic> _$VideoSchemaToJson(VideoSchema instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'thumbnail_path': instance.thumbnailPath,
      'title': instance.title,
      'genre': instance.genre,
      'singer': instance.singer,
      'tags': instance.tags,
      'length': instance.length,
      'difficultyAvg': instance.difficultyAvg,
      'play_count': instance.playCount,
    };
