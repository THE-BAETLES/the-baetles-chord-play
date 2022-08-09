import 'package:the_baetles_chord_play/model/api/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';
part 'get_condition_sheet_response.g.dart';

@JsonSerializable()
class GetConditionSheetResponse extends Response<List<SheetSchema>>{
  GetConditionSheetResponse(String code, String message, List<SheetSchema> data) : super(code: code, message: message, data: data);
  factory GetConditionSheetResponse.fromJson(Map<String, dynamic> json) => _$GetConditionSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetConditionSheetResponseToJson(this);
}
