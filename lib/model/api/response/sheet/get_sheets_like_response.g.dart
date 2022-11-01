// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sheets_like_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSheetsLikeResponse _$GetSheetsLikeResponseFromJson(
        Map<String, dynamic> json) =>
    GetSheetsLikeResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSheetsLikeResponseToJson(
        GetSheetsLikeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
