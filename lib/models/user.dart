import 'gender.dart';
import 'language.dart';
import 'level.dart';
import 'login_type.dart';
import 'membership.dart';
import 'performer_grade.dart';

class User {
  final String userId;
  final String nickName;
  final LoginPlatform loginPlatform;
  final String country;
  final Language language;
  final Gender gender;
  final Level level;
  final int experience;
  final PerformerGrade performerGrade;
  final Membership membership;

  User(this.userId,
      this.nickName,
      this.loginPlatform,
      this.country,
      this.language,
      this.gender,
      this.level,
      this.experience,
      this.performerGrade,
      this.membership);
}