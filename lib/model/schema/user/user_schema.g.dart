// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSchema _$UserSchemaFromJson(Map<String, dynamic> json) => UserSchema(
      id: json['_id'] as String,
      country: json['country'] as String,
      firebaseUid: json['firebase_uid'] as String,
      gender: json['gender'] as String,
      language: json['language'] as String,
      level: json['level'] as String,
      memberShip: json['membership'] as String,
      myCollection: json['myCollection'] as String,
      nickname: json['nickname'] as String,
      performerGrade: json['performer_grade'] as String,
      signupFavorites: json['signupFavorites'] as String,
    );

Map<String, dynamic> _$UserSchemaToJson(UserSchema instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nickname': instance.nickname,
      'firebase_uid': instance.firebaseUid,
      'country': instance.country,
      'language': instance.language,
      'gender': instance.gender,
      'level': instance.level,
      'performer_grade': instance.performerGrade,
      'membership': instance.memberShip,
      'signupFavorites': instance.signupFavorites,
      'myCollection': instance.myCollection,
    };
