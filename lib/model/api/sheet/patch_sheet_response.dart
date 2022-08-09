import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'patch_sheet_response.g.dart';

@JsonSerializable()
class PatchSheetResponse extends Response<SheetSchema>{
  PatchSheetResponse(String code, String message, SheetSchema data) : super(code: code, message: message, data: data);
  factory PatchSheetResponse.fromJson(Map<String, dynamic> json) => _$PatchSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PatchSheetResponseToJson(this);
}

