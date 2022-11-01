import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:the_baetles_chord_play/domain/model/chord_block.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_condition_sheet_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_sheet_data_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_sheets_like_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/get_sheets_my_response.dart';
import 'package:the_baetles_chord_play/model/api/response/sheet/patch_sheet_data_response.dart';
import 'package:the_baetles_chord_play/router/client.dart';
import 'package:the_baetles_chord_play/router/rest_client_factory.dart';

import '../../domain/model/chord.dart';
import '../../domain/model/sheet_data.dart';
import '../../domain/model/sheet_info.dart';
import '../../model/api/request/sheet/patch_sheet_data_request.dart';
import '../../model/api/request/sheet/post_sheet_duplication_request.dart';
import '../../model/api/response/sheet/delete_sheet_like_response.dart';
import '../../model/api/response/sheet/delete_sheet_response.dart';
import '../../model/api/response/sheet/post_sheet_duplication_response.dart';
import '../../model/api/response/sheet/post_sheet_like_response.dart';
import '../../model/schema/sheet/chord_schema.dart';
import '../../model/schema/sheet/sheet_schema.dart';
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
  
  Future<List<SheetInfo>> getMySheets() async {
    final SheetClient client = RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    final GetSheetsMyResponse response = await client.getMySheets();
    final List<SheetInfo> mySheets = [];

    for (SheetSchema sheetSchema in response.data!) {
      mySheets.add(sheetSchema.toSheetInfo());
    }

    return mySheets;
  }

  Future<List<SheetInfo>> getLikedSheets() async {
    final SheetClient client = RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    final GetSheetsLikeResponse response = await client.getMyLikeSheets();
    final List<SheetInfo> myLikeSheets = [];

    for (SheetSchema sheetSchema in response.data!) {
      myLikeSheets.add(sheetSchema.toSheetInfo());
    }

    return myLikeSheets;
  }

  Future<SheetData?> fetchSheetDataBySheetId(String sheetId) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    GetSheetDataResponse? response;

    try {
      response = await client.getSheetData(sheetId);
    } catch (e) {
      return null;
    }

    SheetData? sheetData;

    if (response.code == "200") {
      sheetData = response.toSheetData();
    }

    return sheetData;
  }

  Future<SheetInfo?> createSheetDuplication(
    String sheetId,
    String title,
  ) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    PostSheetDuplicationResponse response = await client.postSheetDuplication(
      PostSheetDuplicationRequest(
        sheetId: sheetId,
        title: title,
      ),
    );

    if (response.code == "201") {
      return response.data!.toSheetInfo();
    } else {
      return null;
    }
  }

  Future<bool> patchSheet(String sheetId, int position, Chord? chord) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    PatchSheetDataResponse response = await client.patchSheet(
      sheetId,
      PatchSheetDataRequest(
        position: position,
        chord: ChordSchema.fromChord(chord),
      ),
    );

    return response.code == "200";
  }

  Future<bool> deleteSheet(String sheetId) async {
    SheetClient client =
        RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    DeleteSheetResponse response = await client.deleteSheet(sheetId);

    return response.code == "200";
  }

  Future<void> addLike(String sheetId) async {
    SheetClient client = RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    PostSheetLikeResponse response = await client.postSheetLike(sheetId);

    return;
  }

  Future<void> deleteLike(String sheetId) async {
    SheetClient client = RestClientFactory().getClient(RestClientType.sheet) as SheetClient;

    DeleteSheetLikeResponse response = await client.deleteSheetLike(sheetId);

    return;
  }
}
