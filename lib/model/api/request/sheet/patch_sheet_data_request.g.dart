// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_sheet_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchSheetDataRequest _$PatchSheetDataRequestFromJson(
        Map<String, dynamic> json) =>
    PatchSheetDataRequest(
      position: json['position'] as int,
      chord: json['chord'] as String,
    );

Map<String, dynamic> _$PatchSheetDataRequestToJson(
        PatchSheetDataRequest instance) =>
    <String, dynamic>{
      'position': instance.position,
      'chord': instance.chord,
    };
