// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyCollectionResponse _$GetMyCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyCollectionResponse(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyCollectionResponseToJson(
        GetMyCollectionResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
