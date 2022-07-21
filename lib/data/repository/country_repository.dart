import 'package:geolocator_platform_interface/src/models/position.dart';

import '../../service/geolocator_service.dart';
import 'dart:io' show Platform;

class CountryRepository {
  static final CountryRepository _instance = CountryRepository.internal();

  factory CountryRepository() {
    return _instance;
  }

  CountryRepository.internal() {
    // TODO : source 연결
  }

  Future<String> getPlatformLocaleName() async {
    return Platform.localeName;
  }
}