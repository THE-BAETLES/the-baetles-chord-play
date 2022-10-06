import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_condition_sheet_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_sheet_data_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/patch_sheet_data_response.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';

import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../model/api/request/sheet/patch_sheet_data_request.dart';
import '../../model/api/request/sheet/post_sheet_duplication_request.dart';
import '../../model/api/response/sheet/post_sheet_duplication_response.dart';
import '../../router/sheet/sheet_client.dart';

class SheetRepository {
  static final SheetRepository _instance = SheetRepository._internal();

  factory SheetRepository() {
    return _instance;
  }

  SheetRepository._internal();

  Future<Map<String, List<SheetInfo>>> fetchSheetsByVideoId(
      String videoId) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;
    GetConditionSheetResponse response =
        await client.getSheetsByVideoId(videoId);
    Map<String, List<SheetInfo>> sheets = response.data!.toMap();

    return sheets;
  }

  Future<SheetData?> fetchSheetDataBySheetId(String sheetId) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    GetSheetDataResponse? response;

    try {
      response = await client.getSheetData(sheetId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return null;
    }

    SheetData? sheetData;

    if (response.code == "200") {
      sheetData = response.toSheetData();
    }

    return sheetData;
  }

  Future<bool> createSheetDuplication(
      String sheetId, String title) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    PostSheetDuplicationResponse response = await client.postSheetDuplication(
      PostSheetDuplicationRequest(
        sheetId: sheetId,
        title: title,
      ),
    );

    return response.code == "200";
  }

  Future<bool> patchSheet(String sheetId, int position, String chord) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    PatchSheetDataResponse response = await client.patchSheet(
      sheetId,
      PatchSheetDataRequest(
        position: position,
        chord: chord,
      ),
    );

    return response.code == "200";
  }
}
