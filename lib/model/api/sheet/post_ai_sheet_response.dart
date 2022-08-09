import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_ai_sheet_response.g.dart';


@JsonSerializable()
class PostAiSheetResponse extends Response<SheetSchema> {
  PostAiSheetResponse(String code, String message, SheetSchema data) : super(code: code, message: message, data: data);
  factory PostAiSheetResponse.fromJson(Map<String, dynamic> json) => _$PostAiSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostAiSheetResponseToJson(this);
}
