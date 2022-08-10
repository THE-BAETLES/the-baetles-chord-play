// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationResponse _$RecommendationResponseFromJson(
        Map<String, dynamic> json) =>
    RecommendationResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecommendationResponseToJson(
        RecommendationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
