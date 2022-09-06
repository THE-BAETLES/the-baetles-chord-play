// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSheetResponse _$PostSheetResponseFromJson(Map<String, dynamic> json) =>
    PostSheetResponse(
      json['code'] as String,
      json['message'] as String,
      SheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostSheetResponseToJson(PostSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
