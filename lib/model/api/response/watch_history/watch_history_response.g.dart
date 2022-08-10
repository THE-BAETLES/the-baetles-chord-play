// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchHistoryResponse _$WatchHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    WatchHistoryResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WatchHistoryResponseToJson(
        WatchHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
