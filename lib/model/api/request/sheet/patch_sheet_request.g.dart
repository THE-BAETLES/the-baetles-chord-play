// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_sheet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchSheetRequest _$PatchSheetRequestFromJson(Map<String, dynamic> json) =>
    PatchSheetRequest(
      sheet: SheetSchema.fromJson(json['sheet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatchSheetRequestToJson(PatchSheetRequest instance) =>
    <String, dynamic>{
      'sheet': instance.sheet,
    };
