import 'dart:convert';

import 'sign_in_platform.dart';
import 'gender.dart';
import 'language.dart';
import 'membership.dart';

class User {
  late final String userId;
  late final String nickName;
  late final SignInPlatform signInPlatform;
  late final String country;
  late final Language language;
  late final Gender gender;
  late final Membership membership;

  User(this.userId,
      this.nickName,
      this.signInPlatform,
      this.country,
      this.language,
      this.gender,
      this.membership);

  User.fromJson(dynamic json) {
    userId = json['userId'];
    nickName = json['nickName'];
    signInPlatform = SignInPlatform.values.firstWhere(
            (e) => e.toString() == json['signInPlatform']);
    country = json['country'];
    language = Language.values.firstWhere(
            (e) => e.toString() == json['language']);
    gender = Gender.values.firstWhere(
            (e) => e.toString() == json['gender']);
    membership = Membership.values.firstWhere(
            (e) => e.toString() == json['membership']);
  }
}