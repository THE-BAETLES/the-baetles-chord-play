import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_sheet_my_response.g.dart';

@JsonSerializable()
class GetSheetMyResponse extends Response<List<SheetSchema>>{
  GetSheetMyResponse(String code, String message, List<SheetSchema> data) : super(code: code, message: message, data: data);
  factory GetSheetMyResponse.fromJson(Map<String, dynamic> json) => _$GetSheetMyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetMyResponseToJson(this);
}