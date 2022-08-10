import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

import '../../../../domain/model/gender.dart';
import '../../../../domain/model/performer_grade.dart';
import '../request.dart';

@JsonSerializable()
class PostUserRequest extends Request {
  String country;
  PerformerGrade performerGrade;
  @JsonKey(name: 'signup_favorite')
  List<VideoSchema> earlyFavoriteSongs;

  String nickname;
  Gender gender;
  PostUserRequest({required this.country, required this.performerGrade,
    required this.earlyFavoriteSongs, required this.nickname, required this.gender});
}
// class PatchSheetRequest extends Request {
//   SheetSchema sheet;
//   PatchSheetRequest({required this.sheet});
//   factory PatchSheetRequest.fromJson(Map<String, dynamic> json) => _$PatchSheetRequestFromJson(json);
//   Map<String, dynamic> toJson() => _$PatchSheetRequestToJson(this);
// }
