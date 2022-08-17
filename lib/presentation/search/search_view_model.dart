import 'package:flutter/cupertino.dart';

import '../../domain/model/video.dart';
import '../../domain/use_case/search_video.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchVideo _searchVideo;
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  SearchViewModel(this._searchVideo);

  List<Video> searchResult = [];

  void search(String searchTitle) async {
    searchResult = await _searchVideo(searchTitle);
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}