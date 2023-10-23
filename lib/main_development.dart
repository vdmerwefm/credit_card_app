import 'package:banned_country_repo/banned_country_repo.dart';
import 'package:credit_card/app/view/app.dart';
import 'package:credit_card/bootstrap.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:local_storage_banned_country_api/local_storage_banned_country_api.dart';
import 'package:local_storage_credit_card_api/local_storage_credit_card_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final creditCardApi = LocalStorageCreditCardApi(
    storeCreditCard: await SharedPreferences.getInstance(),
  );
  final bannedCountryApi = LocalStorageBannedCountryApi(
    storeCountry: await SharedPreferences.getInstance(),
  );
  final creditCardRepository =
      CreditCardRepository(creditCardApi: creditCardApi);
  final bannedCountryRepo =
      BannedCountryRepo(bannedCountryApi: bannedCountryApi);

  await bootstrap(
    () => App(
      creditCardRepository: creditCardRepository,
      bannedCountryRepo: bannedCountryRepo,
    ),
    creditCardApi: creditCardApi,
  );
}
