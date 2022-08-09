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
      (json['data'] as List<dynamic>)
          .map((e) => SheetSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConditionSheetResponseToJson(
        GetConditionSheetResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
