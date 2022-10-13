// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sheet_duplication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSheetDuplicationResponse _$PostSheetDuplicationResponseFromJson(
        Map<String, dynamic> json) =>
    PostSheetDuplicationResponse(
      json['code'] as String,
      json['message'] as String,
      SheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostSheetDuplicationResponseToJson(
        PostSheetDuplicationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
