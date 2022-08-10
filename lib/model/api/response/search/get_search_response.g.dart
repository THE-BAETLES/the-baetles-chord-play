// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchResponse _$GetSearchResponseFromJson(Map<String, dynamic> json) =>
    GetSearchResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchResponseToJson(GetSearchResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
