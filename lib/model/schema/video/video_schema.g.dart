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
      difficultyAvg: json['difficulty_avg'] as int,
      playCount: json['play_count'] as int,
      sheetCount: json['sheet_count'] as int,
      isInMyCollection: json['is_in_my_collection'] as bool,
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
      'difficulty_avg': instance.difficultyAvg,
      'play_count': instance.playCount,
      'sheet_count': instance.sheetCount,
      'is_in_my_collection': instance.isInMyCollection,
    };
