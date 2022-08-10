// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheet_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetDataResponse _$GetSheetDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetSheetDataResponse(
      json['code'] as String,
      json['message'] as String,
      SheetDataSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSheetDataResponseToJson(
        GetSheetDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
