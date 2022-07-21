import '../../data/repository/country_repository.dart';

class GetUserCountry {
  final CountryRepository countryRepository;

  GetUserCountry(this.countryRepository);

  Future<String> call() async {
    return await countryRepository.getPlatformLocaleName();
  }
}