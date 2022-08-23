import 'package:flutter/cupertino.dart';

import '../../domain/model/video.dart';
import '../../domain/use_case/search_video.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchVideo _searchVideo;
  final TextEditingController _controller = TextEditingController();
  List<Video> _searchResult = [];

  TextEditingController get controller => _controller;
  List<Video> get searchResult => _searchResult;

  SearchViewModel(this._searchVideo);

  void search(String searchTitle) async {
    _searchResult = await _searchVideo(searchTitle);
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.clear();
    searchResult.clear();
    super.dispose();
  }
}