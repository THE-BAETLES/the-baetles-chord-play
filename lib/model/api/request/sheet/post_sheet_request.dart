import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_baetles_chord_play/model/api/request/request.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_data_schema.dart';
import 'package:the_baetles_chord_play/model/schema/sheet/sheet_schema.dart';

part 'post_sheet_request.g.dart';

@JsonSerializable()
class PostSheetRequest extends Request{
    SheetDataSchema sheetData;
    RequestSheetInfo sheet;

    PostSheetRequest({required this.sheetData, required this.sheet});

    factory PostSheetRequest.fromJson(Map<String, dynamic> json) => _$PostSheetRequestFromJson(json);
    Map<String, dynamic> toJson() => _$PostSheetRequestToJson(this);
}

@JsonSerializable()
class RequestSheetInfo {
    String videoId;
    String title;
    RequestSheetInfo({required this.videoId, required this.title});

    factory RequestSheetInfo.fromJson(Map<String, dynamic> json) => _$RequestSheetInfoFromJson(json);
    Map<String, dynamic> toJson() => _$RequestSheetInfoToJson(this);
}