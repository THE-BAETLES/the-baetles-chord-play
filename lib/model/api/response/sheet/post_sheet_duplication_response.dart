import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_sheet_duplication_response.g.dart';

@JsonSerializable()
class PostSheetDuplicationResponse extends Response<SheetSchema> {
  PostSheetDuplicationResponse(String code, String message, SheetSchema data) : super(code: code, message: message, data: data);
  factory PostSheetDuplicationResponse.fromJson(Map<String, dynamic> json) => _$PostSheetDuplicationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostSheetDuplicationResponseToJson(this);
}

