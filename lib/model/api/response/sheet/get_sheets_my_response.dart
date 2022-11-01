import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_sheets_my_response.g.dart';

@JsonSerializable()
class GetSheetsMyResponse extends Response<List<SheetSchema>>{
  GetSheetsMyResponse(String code, String message, List<SheetSchema> data) : super(code: code, message: message, data: data);
  factory GetSheetsMyResponse.fromJson(Map<String, dynamic> json) => _$GetSheetsMyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetsMyResponseToJson(this);
}