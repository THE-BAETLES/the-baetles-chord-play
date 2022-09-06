// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sheet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSheetRequest _$PostSheetRequestFromJson(Map<String, dynamic> json) =>
    PostSheetRequest(
      requestSheetInfo: RequestSheetInfo.fromJson(
          json['requestSheetInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostSheetRequestToJson(PostSheetRequest instance) =>
    <String, dynamic>{
      'requestSheetInfo': instance.requestSheetInfo,
    };

RequestSheetInfo _$RequestSheetInfoFromJson(Map<String, dynamic> json) =>
    RequestSheetInfo(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$RequestSheetInfoToJson(RequestSheetInfo instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
    };
