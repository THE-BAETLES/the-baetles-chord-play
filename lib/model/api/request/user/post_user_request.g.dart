// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUserRequest _$PostUserRequestFromJson(Map<String, dynamic> json) =>
    PostUserRequest(
      country: json['country'] as String,
      performerGrade:
          $enumDecode(_$PerformerGradeEnumMap, json['performerGrade']),
      earlyFavoriteSongs: (json['signup_favorite'] as List<dynamic>)
          .map((e) => VideoSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
      nickname: json['nickname'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$PostUserRequestToJson(PostUserRequest instance) =>
    <String, dynamic>{
      'country': instance.country,
      'performerGrade': _$PerformerGradeEnumMap[instance.performerGrade]!,
      'signup_favorite': instance.earlyFavoriteSongs,
      'nickname': instance.nickname,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$PerformerGradeEnumMap = {
  PerformerGrade.beginner: 'beginner',
  PerformerGrade.intermediate: 'intermediate',
  PerformerGrade.expert: 'expert',
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
