// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sheet_duplication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSheetDuplicationRequest _$PostSheetDuplicationRequestFromJson(
        Map<String, dynamic> json) =>
    PostSheetDuplicationRequest(
      sheetId: json['sheet_id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$PostSheetDuplicationRequestToJson(
        PostSheetDuplicationRequest instance) =>
    <String, dynamic>{
      'sheet_id': instance.sheetId,
      'title': instance.title,
    };
