import 'package:the_baetles_chord_play/model/schema/schema.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_schema.g.dart';

@JsonSerializable()
class UserSchema {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'firebase_uid')
  String firebaseUid;

  @JsonKey(name: 'roles')
  String roles;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'language')
  String? language;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'performer_grade')
  String? performerGrade;

  @JsonKey(name: 'membership')
  String? memberShip;

  @JsonKey(name: 'signup_favorite')
  List<String> signupFavorites;

  @JsonKey(name: 'my_collection')
  List<String> myCollection;

  UserSchema({
    required this.id,
    required this.country,
    required this.firebaseUid,
    required this.gender,
    required this.language,
    required this.memberShip,
    required this.myCollection,
    required this.nickname,
    required this.performerGrade,
    required this.signupFavorites,
    required this.username,
    required this.roles,
    required this.email,
  });

  factory UserSchema.fromJson(Map<String, dynamic> json) =>
      _$UserSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$UserSchemaToJson(this);
}
