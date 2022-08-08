import 'dart:collection';

import 'package:the_baetles_chord_play/data/repository/auth_repository.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_sheets_of_video.dart';

import '../model/sheet_info.dart';

class GetMySheetsOfVideo {
  final GetSheetsOfVideo getSheetsOfVideo;
  final AuthRepository authRepository;

  GetMySheetsOfVideo(this.getSheetsOfVideo, this.authRepository);

  Future<UnmodifiableListView<SheetInfo>> call(String videoId) async {
    UnmodifiableListView<SheetInfo> sheets = await getSheetsOfVideo(videoId);
    String? idToken = await authRepository.fetchIdToken();

    List<SheetInfo> mySheets = sheets.where((sheet) => sheet.userId == idToken).toList();
    return UnmodifiableListView<SheetInfo>(mySheets);
  }
}
