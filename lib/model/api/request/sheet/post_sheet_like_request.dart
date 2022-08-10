import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/request/request.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_data_schema.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_sheet_like_request.g.dart';

@JsonSerializable()
class PostSheetLikeRequest extends Request {
  @JsonKey(name: 'sheet_id')
  String sheetId;
  PostSheetLikeRequest({required this.sheetId});
  factory PostSheetLikeRequest.fromJson(Map<String, dynamic> json) => _$PostSheetLikeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetLikeRequestToJson(this);
}