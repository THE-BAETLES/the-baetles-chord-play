// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_sheet_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchSheetDataRequest _$PatchSheetDataRequestFromJson(
        Map<String, dynamic> json) =>
    PatchSheetDataRequest(
      position: json['position'] as int,
      chord: ChordSchema.fromJson(json['chord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatchSheetDataRequestToJson(
        PatchSheetDataRequest instance) =>
    <String, dynamic>{
      'position': instance.position,
      'chord': instance.chord,
    };
