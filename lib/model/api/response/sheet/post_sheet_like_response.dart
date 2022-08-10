import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_sheet_like_response.g.dart';

@JsonSerializable()
class PostSheetLikeResponse extends Response<String>{
  PostSheetLikeResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory PostSheetLikeResponse.fromJson(Map<String, dynamic> json) => _$PostSheetLikeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetLikeResponseToJson(this);
}