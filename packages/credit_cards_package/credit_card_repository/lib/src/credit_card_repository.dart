import 'package:credit_card_api/credit_card_api.dart';

class CreditCardRepository {
  const CreditCardRepository({
    required CreditCardApi creditCardApi,
  }) : _creditCardApi = creditCardApi;

  final CreditCardApi _creditCardApi;

  Stream<List<CreditCard>> getCreditCards() => _creditCardApi.getCreditCards();

  Future<void> saveCreditCards(CreditCard creditCard) =>
      _creditCardApi.saveCreditCard(creditCard);

  Future<void> deleteCreditCards(String id) =>
      _creditCardApi.deleteCreditCard(id);
}
