// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheet_like_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetLikeResponse _$GetSheetLikeResponseFromJson(
        Map<String, dynamic> json) =>
    GetSheetLikeResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetSheetLikeResponseToJson(
        GetSheetLikeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
