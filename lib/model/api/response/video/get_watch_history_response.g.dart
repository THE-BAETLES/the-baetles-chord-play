// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_watch_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWatchHistoryResponse _$GetWatchHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetWatchHistoryResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetWatchHistoryResponseToJson(
        GetWatchHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
