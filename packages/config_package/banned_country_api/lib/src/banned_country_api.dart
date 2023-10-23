import 'package:banned_country_api/banned_country_api.dart';

abstract class BannedCountryApi {
  const BannedCountryApi();

  Stream<List<BannedCountry>> getBannedCountries();

  Future<void> banCountry(BannedCountry bannedCountry);

  Future<void> unbanCountry(BannedCountry bannedCountry);
}

class BannedCountryNotFoundException implements Exception {}
