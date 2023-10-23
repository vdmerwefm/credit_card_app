import 'package:banned_country_repo/banned_country_repo.dart';
import 'package:credit_card/app/app.dart';
import 'package:credit_card/counter/counter.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_banned_country_api/local_storage_banned_country_api.dart';
import 'package:local_storage_credit_card_api/local_storage_credit_card_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
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

      await tester.pumpWidget(
        App(
          creditCardRepository: creditCardRepository,
          bannedCountryRepo: bannedCountryRepo,
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
