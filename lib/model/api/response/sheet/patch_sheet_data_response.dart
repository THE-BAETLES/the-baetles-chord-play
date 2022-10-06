import 'package:the_baetles_chord_play/model/api/response/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'patch_sheet_data_response.g.dart';

@JsonSerializable()
class PatchSheetDataResponse extends Response<String>{
  PatchSheetDataResponse(String code, String message, String data) : super(code: code, message: message, data: data);
  factory PatchSheetDataResponse.fromJson(Map<String, dynamic> json) => _$PatchSheetDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PatchSheetDataResponseToJson(this);
}

