import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_condition_sheet_response.g.dart';

@JsonSerializable()
class GetConditionSheetResponse extends Response<AllSheetSchema> {
  GetConditionSheetResponse(String code, String message, AllSheetSchema data) : super(code: code, message: message, data: data);
  factory GetConditionSheetResponse.fromJson(Map<String, dynamic> json) => _$GetConditionSheetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetConditionSheetResponseToJson(this);
}
