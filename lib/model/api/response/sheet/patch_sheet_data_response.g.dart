// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_sheet_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchSheetDataResponse _$PatchSheetDataResponseFromJson(
        Map<String, dynamic> json) =>
    PatchSheetDataResponse(
      json['code'] as String,
      json['message'] as String,
      json['data'] as String,
    );

Map<String, dynamic> _$PatchSheetDataResponseToJson(
        PatchSheetDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
