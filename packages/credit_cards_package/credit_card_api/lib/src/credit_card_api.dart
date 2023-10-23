import 'package:credit_card_api/credit_card_api.dart';

abstract class CreditCardApi {

  const CreditCardApi();

  Stream<List<CreditCard>> getCreditCards();

  Future<void> saveCreditCard(CreditCard creditCard);

  Future<void> deleteCreditCard(String id);
}

class CreditCardsNotFoundException implements Exception {}
