// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_video_grade_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVideoGradeCollectionResponse _$GetVideoGradeCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    GetVideoGradeCollectionResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetVideoGradeCollectionResponseToJson(
        GetVideoGradeCollectionResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
