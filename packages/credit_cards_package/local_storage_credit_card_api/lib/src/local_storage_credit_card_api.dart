import 'dart:async';
import 'dart:convert';

import 'package:credit_card_api/credit_card_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageCreditCardApi extends CreditCardApi {
  LocalStorageCreditCardApi({required SharedPreferences storeCreditCard})
      : _storeCreditCard = storeCreditCard {
    _init();
  }

  final SharedPreferences _storeCreditCard;
  final _creditCardStreamController =
      BehaviorSubject<List<CreditCard>>.seeded(const []);

  static const kCreditCardCollectionKey = '__cedit_card_collection_key__';

  @override
  Stream<List<CreditCard>> getCreditCards() =>
      _creditCardStreamController.asBroadcastStream();

  String? _getCreditCard(String key) => _storeCreditCard.getString(key);

  Future<void> _setCreditCard(String key, String value) =>
      _storeCreditCard.setString(key, value);

  void _init() {
    final creditCardJson = _getCreditCard(kCreditCardCollectionKey);
    if (creditCardJson != null) {
      final creditCard =
          List<Map<String, dynamic>>.from(jsonDecode(creditCardJson) as List)
              .map(
                (jsonMap) =>
                    CreditCard.fromJson(Map<String, dynamic>.from(jsonMap)),
              )
              .toList();
      _creditCardStreamController.add(creditCard);
    } else {
      _creditCardStreamController.add(const []);
    }
  }

  @override
  Future<void> saveCreditCard(CreditCard creditCard) {
    if (creditCard.creditCardNumber !=
            _storeCreditCard.getString(creditCard.creditCardNumber) &&
        !_creditCardStreamController.value
            .toString()
            .contains(creditCard.creditCardNumber)) {
      {
        final addCreditCard = [..._creditCardStreamController.value];
        final addCardIndex =
            addCreditCard.indexWhere((card) => card.id == creditCard.id);
        if (addCardIndex >= 0) {
          addCreditCard[addCardIndex] = creditCard;
        } else {
          addCreditCard.add(creditCard);
        }

        _creditCardStreamController.add(addCreditCard);
        return _setCreditCard(
          kCreditCardCollectionKey,
          json.encode(addCreditCard),
        );
      }
    } else {
      throw Exception('could not save');
    }
  }

  @override
  Future<void> deleteCreditCard(String id) {
    final removeCreditCard = [..._creditCardStreamController.value];
    final removeCardIndex =
        removeCreditCard.indexWhere((card) => card.id == id);
    if (removeCardIndex == -1) {
      throw CreditCardsNotFoundException();
    } else {
      removeCreditCard.removeAt(removeCardIndex);
      _creditCardStreamController.add(removeCreditCard);
      return _setCreditCard(
        kCreditCardCollectionKey,
        json.encode(removeCreditCard),
      );
    }
  }
  
}
