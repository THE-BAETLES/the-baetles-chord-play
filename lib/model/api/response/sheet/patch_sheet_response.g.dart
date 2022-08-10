// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchSheetResponse _$PatchSheetResponseFromJson(Map<String, dynamic> json) =>
    PatchSheetResponse(
      json['code'] as String,
      json['message'] as String,
      SheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatchSheetResponseToJson(PatchSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
