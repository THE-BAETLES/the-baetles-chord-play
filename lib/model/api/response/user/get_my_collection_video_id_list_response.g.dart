// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_collection_video_id_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyCollectionVideoIdListResponse _$GetMyCollectionVideoIdListResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyCollectionVideoIdListResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetMyCollectionVideoIdListResponseToJson(
        GetMyCollectionVideoIdListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
