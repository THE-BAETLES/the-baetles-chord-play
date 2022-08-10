// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetResponse _$GetSheetResponseFromJson(Map<String, dynamic> json) =>
    GetSheetResponse(
      json['code'] as String,
      json['message'] as String,
      SheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSheetResponseToJson(GetSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
