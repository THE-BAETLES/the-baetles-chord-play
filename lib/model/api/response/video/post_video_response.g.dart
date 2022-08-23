// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostVideoResponse _$PostVideoResponseFromJson(Map<String, dynamic> json) =>
    PostVideoResponse(
      json['code'] as String,
      json['message'] as String,
      VideoSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostVideoResponseToJson(PostVideoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
