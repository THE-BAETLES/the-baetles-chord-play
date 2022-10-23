// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSchema _$UserSchemaFromJson(Map<String, dynamic> json) => UserSchema(
      id: json['id'] as String,
      country: json['country'] as String?,
      firebaseUid: json['firebase_uid'] as String,
      gender: json['gender'] as String?,
      language: json['language'] as String?,
      memberShip: json['membership'] as String?,
      myCollection: (json['my_collection'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nickname: json['nickname'] as String,
      performerGrade: json['performer_grade'] as String?,
      signupFavorites: (json['signup_favorite'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      username: json['username'] as String,
      roles: json['roles'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserSchemaToJson(UserSchema instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'username': instance.username,
      'firebase_uid': instance.firebaseUid,
      'roles': instance.roles,
      'email': instance.email,
      'country': instance.country,
      'language': instance.language,
      'gender': instance.gender,
      'performer_grade': instance.performerGrade,
      'membership': instance.memberShip,
      'signup_favorite': instance.signupFavorites,
      'my_collection': instance.myCollection,
    };
