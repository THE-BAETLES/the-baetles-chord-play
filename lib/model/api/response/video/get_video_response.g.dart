// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_video_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVideoResponse _$GetVideoResponseFromJson(Map<String, dynamic> json) =>
    GetVideoResponse(
      json['code'] as String,
      json['message'] as String,
      VideoSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetVideoResponseToJson(GetVideoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
