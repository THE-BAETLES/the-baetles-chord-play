// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_my_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostMyCollectionResponse _$PostMyCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    PostMyCollectionResponse(
      json['code'] as String,
      json['message'] as String,
      json['data'] as String,
    );

Map<String, dynamic> _$PostMyCollectionResponseToJson(
        PostMyCollectionResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
