// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheet_shared_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetSharedResponse _$GetSheetSharedResponseFromJson(
        Map<String, dynamic> json) =>
    GetSheetSharedResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSheetSharedResponseToJson(
        GetSheetSharedResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
