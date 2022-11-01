// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserResponse _$GetUserResponseFromJson(Map<String, dynamic> json) =>
    GetUserResponse(
      json['code'] as String,
      json['message'] as String,
      UserSchema.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserResponseToJson(GetUserResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
