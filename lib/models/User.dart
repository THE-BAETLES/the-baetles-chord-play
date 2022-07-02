import 'Gender.dart';
import 'Language.dart';
import 'Level.dart';
import 'LoginType.dart';
import 'Membership.dart';
import 'PerformerGrade.dart';

class User {
  final String userId;
  final LoginPlatform loginPlatform;
  final String country;
  final Language language;
  final Gender gender;
  final Level level;
  final int experience;
  final PerformerGrade performerGrade;
  final Membership membership;

  User(this.userId,
      this.loginPlatform,
      this.country,
      this.language,
      this.gender,
      this.level,
      this.experience,
      this.performerGrade,
      this.membership);
}