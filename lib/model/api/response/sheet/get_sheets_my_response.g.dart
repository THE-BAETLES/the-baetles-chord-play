// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheets_my_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetsMyResponse _$GetSheetsMyResponseFromJson(Map<String, dynamic> json) =>
    GetSheetsMyResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSheetsMyResponseToJson(
        GetSheetsMyResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
