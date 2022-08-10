import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'delete_sheet_response.g.dart';

@JsonSerializable()
class DeleteSheetResponse extends Response<SheetSchema>{
  DeleteSheetResponse(String code, String message, SheetSchema data) : super(code: code, message: message, data: data);
  factory DeleteSheetResponse.fromJson(Map<String, dynamic> json) => _$DeleteSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteSheetResponseToJson(this);
}