// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_condition_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConditionSheetResponse _$GetConditionSheetResponseFromJson(
        Map<String, dynamic> json) =>
    GetConditionSheetResponse(
      json['code'] as String,
      json['message'] as String,
      AllSheetSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetConditionSheetResponseToJson(
        GetConditionSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
