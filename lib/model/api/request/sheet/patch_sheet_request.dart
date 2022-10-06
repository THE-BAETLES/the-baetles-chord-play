import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/request/request.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';
part 'patch_sheet_request.g.dart';

@JsonSerializable()
class PatchSheetRequest extends Request {
  SheetSchema sheet;
  PatchSheetRequest({required this.sheet});
  factory PatchSheetRequest.fromJson(Map<String, dynamic> json) => _$PatchSheetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchSheetRequestToJson(this);
}