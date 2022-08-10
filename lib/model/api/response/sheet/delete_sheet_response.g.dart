// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteSheetResponse _$DeleteSheetResponseFromJson(Map<String, dynamic> json) =>
    DeleteSheetResponse(
      json['code'] as String,
      json['message'] as String,
      SheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeleteSheetResponseToJson(
        DeleteSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
