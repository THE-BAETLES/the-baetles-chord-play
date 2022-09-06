// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sheet_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSheetDataResponse _$PostSheetDataResponseFromJson(
        Map<String, dynamic> json) =>
    PostSheetDataResponse(
      json['code'] as String,
      json['message'] as String,
      json['data'] as String,
    );

Map<String, dynamic> _$PostSheetDataResponseToJson(
        PostSheetDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
