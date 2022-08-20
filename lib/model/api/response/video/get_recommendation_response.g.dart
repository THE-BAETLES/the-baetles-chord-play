// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRecommendationResponse _$GetRecommendationResponseFromJson(
        Map<String, dynamic> json) =>
    GetRecommendationResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRecommendationResponseToJson(
        GetRecommendationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
