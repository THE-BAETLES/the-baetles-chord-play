import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';
import 'package:the_baetles_chord_play/model/schema/video/video_schema.dart';

part 'get_video_grade_collection_response.g.dart';

@JsonSerializable()
class GetVideoGradeCollectionResponse extends Response<List<VideoSchema>>{
  GetVideoGradeCollectionResponse(String code, String message, List<VideoSchema> data) : super(code: code, message: message, data: data);
  factory GetVideoGradeCollectionResponse.fromJson(Map<String, dynamic> json) => _$GetVideoGradeCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetVideoGradeCollectionResponseToJson(this);
}