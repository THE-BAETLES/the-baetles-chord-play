import 'package:country_codes/country_codes.dart';

class CountryRepository {
  static final CountryRepository _instance = CountryRepository._internal();

  factory CountryRepository() {
    return _instance;
  }

  CountryRepository._internal() {
    // TODO : source 연결
  }

  Future<String?> getCountryCode() async {
    return CountryCodes.getDeviceLocale()?.countryCode;
  }

  Future<String?> getLanguageCode() async {
    return CountryCodes.getDeviceLocale()?.languageCode;
  }
}