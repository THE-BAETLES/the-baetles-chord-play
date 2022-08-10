import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'get_sheet_shared_response.g.dart';

@JsonSerializable()
class GetSheetSharedResponse extends Response<List<SheetSchema>>{
  GetSheetSharedResponse(String code, String message, List<SheetSchema> data) : super(code: code, message: message, data: data);
  factory GetSheetSharedResponse.fromJson(Map<String, dynamic> json) => _$GetSheetSharedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSheetSharedResponseToJson(this);
}