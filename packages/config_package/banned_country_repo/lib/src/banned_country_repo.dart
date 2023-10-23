import 'package:banned_country_api/banned_country_api.dart';

class BannedCountryRepo {
  const BannedCountryRepo({
    required BannedCountryApi bannedCountryApi,
  }) : _bannedCountryApi = bannedCountryApi;

  final BannedCountryApi _bannedCountryApi;

  Stream<List<BannedCountry>> getBannedCountries() =>
      _bannedCountryApi.getBannedCountries();

  Future<void> banCountry(BannedCountry bannedCountry) =>
      _bannedCountryApi.banCountry(bannedCountry);

  Future<void> unbanCountry(BannedCountry bannedCountry) =>
      _bannedCountryApi.unbanCountry(bannedCountry);
}
