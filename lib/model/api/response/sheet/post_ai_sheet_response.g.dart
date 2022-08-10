// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_ai_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAiSheetResponse _$PostAiSheetResponseFromJson(Map<String, dynamic> json) =>
    PostAiSheetResponse(
      json['code'] as String,
      json['message'] as String,
      SheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostAiSheetResponseToJson(
        PostAiSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
