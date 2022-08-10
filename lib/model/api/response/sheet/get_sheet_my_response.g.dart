// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheet_my_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetMyResponse _$GetSheetMyResponseFromJson(Map<String, dynamic> json) =>
    GetSheetMyResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSheetMyResponseToJson(GetSheetMyResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
