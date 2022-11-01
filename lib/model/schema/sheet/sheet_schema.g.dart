// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheet_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SheetSchema _$SheetSchemaFromJson(Map<String, dynamic> json) => SheetSchema(
      id: json['_id'] as String,
      videoId: json['video_id'] as String,
      userId: json['user_id'] as String,
      userNickname: json['user_nickname'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      likeCount: json['like_count'] as int,
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$SheetSchemaToJson(SheetSchema instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'video_id': instance.videoId,
      'user_id': instance.userId,
      'user_nickname': instance.userNickname,
      'title': instance.title,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'like_count': instance.likeCount,
      'liked': instance.liked,
    };

AllSheetSchema _$AllSheetSchemaFromJson(Map<String, dynamic> json) =>
    AllSheetSchema(
      sharedList: (json['shared'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
      likeList: (json['like'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
      myList: (json['my'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllSheetSchemaToJson(AllSheetSchema instance) =>
    <String, dynamic>{
      'shared': instance.sharedList,
      'like': instance.likeList,
      'my': instance.myList,
    };
