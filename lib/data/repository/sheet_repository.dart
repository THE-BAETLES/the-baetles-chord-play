import 'dart:collection';

import '../../domain/model/sheet_music.dart';

class SheetRepository {
  static final SheetRepository _instance = SheetRepository._internal();

  factory SheetRepository() {
    return _instance;
  }

  SheetRepository._internal() {
    // TODO : source 연결
  }

  Future<UnmodifiableListView<SheetMusic>> fetchSheetsByVideoId(
      String videoId) async {
    // TODO : source 연결

    // dummy data
    return UnmodifiableListView([
      SheetMusic(
        id: 'f3WgS5dummyFnyAl',
        videoId: 'sagsefa',
        userId: 'agaewraf',
        title: '내 악보 (2)',
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        likeCount: 1509,
      ),
      SheetMusic(
        id: 'safgeayFnyAl',
        videoId: 'sagsefa',
        userId: 'agaewraf',
        title: '내 악보 (3)',
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        likeCount: 1509,
      ),
      SheetMusic(
        id: 'safgeayFsgeanyAl',
        videoId: 'sagsefa',
        userId: '2524',
        title: 'sheet',
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        likeCount: 1509,
      ),
    ]);
  }
}
