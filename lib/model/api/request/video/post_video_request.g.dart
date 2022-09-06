// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_video_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostVideoRequest _$PostVideoRequestFromJson(Map<String, dynamic> json) =>
    PostVideoRequest(
      video: VideoSchema.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostVideoRequestToJson(PostVideoRequest instance) =>
    <String, dynamic>{
      'video': instance.video,
    };
