// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sheet_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSheetDataRequest _$PostSheetDataRequestFromJson(
        Map<String, dynamic> json) =>
    PostSheetDataRequest(
      sheetData:
          SheetDataSchema.fromJson(json['sheetData'] as Map<String, dynamic>),
      sheet: RequestSheetInfo.fromJson(json['sheet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostSheetDataRequestToJson(
        PostSheetDataRequest instance) =>
    <String, dynamic>{
      'sheetData': instance.sheetData,
      'sheet': instance.sheet,
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
