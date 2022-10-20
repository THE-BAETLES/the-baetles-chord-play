import 'package:flutter/material.dart';
import 'package:the_baetles_chord_play/domain/use_case/get_my_collection.dart';

import '../../data/repository/user_repository.dart';
import '../../domain/model/video.dart';

class CollectionViewModel with ChangeNotifier {
  final GetMyCollection getMyCollection;
  final CollectionRepository collectionRepository;
  List<Video>? _myCollection;

  CollectionViewModel(this.collectionRepository, this.getMyCollection) {
    loadCollection();

    collectionRepository.addMyCollectionChangeListener(() {
      loadCollection();
    });
  }

  List<Video>? get myCollection => _myCollection;

  void loadCollection() async {
    if (_myCollection != null) {
      _myCollection = null;
      notifyListeners();
    }

    _myCollection = await getMyCollection();
    notifyListeners();
  }
}