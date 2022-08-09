import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_sheet_response.g.dart';
@JsonSerializable()
class GetSheetResponse extends Response<SheetSchema>{
  GetSheetResponse(String code, String message, SheetSchema data) : super(code: code, message: message, data: data);
  factory GetSheetResponse.fromJson(Map<String, dynamic> json) => _$GetSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetResponseToJson(this);
}
