import 'dart:async';
import 'dart:convert';
import 'package:banned_country_api/banned_country_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageBannedCountryApi extends BannedCountryApi {
  LocalStorageBannedCountryApi({required SharedPreferences storeCountry})
      : _storeCountry = storeCountry {
    _init();
  }

  final SharedPreferences _storeCountry;
  final _countryStreamController =
      BehaviorSubject<List<BannedCountry>>.seeded(const []);

  static const kBannedCountryCollectionKey =
      '___banned_county_collection_key___';

  @override
  Stream<List<BannedCountry>> getBannedCountries() =>
      _countryStreamController.asBroadcastStream();

  String? _getBannedCountries(String key) => _storeCountry.getString(key);

  Future<void> _setCounrty(String key, String value) =>
      _storeCountry.setString(key, value);

  void _init() {
    final bannedCountryJson = _getBannedCountries(kBannedCountryCollectionKey);
    if (bannedCountryJson != null) {
      final bannedCountry =
          List<Map<String, dynamic>>.from(jsonDecode(bannedCountryJson) as List)
              .map(
                (jsonMap) =>
                    BannedCountry.fromJson(Map<String, dynamic>.from(jsonMap)),
              )
              .toList();
      _countryStreamController.add(bannedCountry);
    } else {
      _countryStreamController.add(const []);
    }
  }

  @override
  Future<void> unbanCountry(BannedCountry bannedCountry) {
    final addCountry = [..._countryStreamController.value];
    final addCountryIndex = addCountry
        .indexWhere((country) => country.country == bannedCountry.country);

    if (addCountryIndex == -1) {
      throw BannedCountryNotFoundException();
    } else {
      addCountry.removeAt(addCountryIndex);
      _countryStreamController.add(addCountry);
      return _setCounrty(kBannedCountryCollectionKey, json.encode(addCountry));
    }
  }

  @override
  Future<void> banCountry(BannedCountry bannedCountry) {
    if (bannedCountry.country !=
        _storeCountry.getString(bannedCountry.country)) {
      final banCountry = [..._countryStreamController.value];
      final banCountryIndex = banCountry
          .indexWhere((country) => country.country == bannedCountry.country);
      if (banCountryIndex > 0) {
        banCountry[banCountryIndex] = bannedCountry;
      } else {
        banCountry.add(bannedCountry);
      }

      _countryStreamController.add(banCountry);
      return _setCounrty(kBannedCountryCollectionKey, json.encode(banCountry));
    } else {
      throw Exception('country already on banned list');
    }
  }
}
