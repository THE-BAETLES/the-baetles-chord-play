import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/request/request.dart';

part 'post_sheet_duplication_request.g.dart';

@JsonSerializable()
class PostSheetDuplicationRequest extends Request {
  @JsonKey(name: 'sheet_id')
  String sheetId;

  @JsonKey(name: 'title')
  String title;

  PostSheetDuplicationRequest({
    required this.sheetId,
    required this.title,
  });

  factory PostSheetDuplicationRequest.fromJson(Map<String, dynamic> json) =>
      _$PostSheetDuplicationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostSheetDuplicationRequestToJson(this);
}
