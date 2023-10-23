import 'package:bloc/bloc.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:credit_card_api/credit_card_api.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:local_storage_credit_card_api/local_storage_credit_card_api.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

part 'credit_card_capture_event.dart';
part 'credit_card_capture_state.dart';

class CreditCardsCaptureBloc
    extends Bloc<CreditCardCaptureEvent, CreditCardCaptureState> {
  CreditCardsCaptureBloc({
    required CreditCardRepository creditCardRepository,
    required CreditCard? creditCard,
  })  : _creditCardRepository = creditCardRepository,
        super(
          CreditCardCaptureState(
            creditCard: creditCard,
          ),
        ) {
    on<CreditCardCaptureEvent>(_cardCaptureRequested);
  }

  final CreditCardRepository _creditCardRepository;

  String cardType = '';

  Future<void> _cardCaptureRequested(
    CreditCardCaptureEvent event,
    Emitter<CreditCardCaptureState> emit,
  ) async {
    final newCard = event.captureCreditCard;
    try {
      await _creditCardRepository.saveCreditCards(newCard);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> _getCards(
  ) async {
    final cards = _creditCardRepository.getCreditCards();
  }

  final cardHolderNameController = BehaviorSubject<String>();
  Stream<String> get cardHolderNameStream => cardHolderNameController.stream;

  void updateCardHolderName(String cardHolderName) {
    if (cardHolderName.isEmpty) {
      cardHolderNameController.sink
          .addError('Please enter the card holder name');
    } else {
      cardHolderNameController.sink.add(cardHolderName.toUpperCase());
    }
  }

  final cardNumberController = BehaviorSubject<String>();
  Stream<String> get cardNumberStream => cardNumberController.stream;

  void updateCardNumber(String cardNumber) {
    if (cardNumber.isEmpty || cardNumber.length < 16) {
      cardNumberController.sink.addError('Please a valid card number');
    } else {
      cardNumberController.sink.add(cardNumber);
    }
  }

  final cvvController = BehaviorSubject<String>();
  Stream<String> get cvvStream => cvvController.stream;

  void updateCVV(String cvv) {
    if (cvv.isEmpty || cvv.length < 3) {
      cvvController.sink.addError('Please enter a valid CVV Number');
    } else {
      cvvController.sink.add(cvv);
    }
  }

  final countryOfIssueController = BehaviorSubject<String>();
  Stream<String> get countryOfIssueStream => countryOfIssueController.stream;

  void updateCountryOfIssue(String countryOfIssue) {
    if (countryOfIssue.isEmpty) {
      countryOfIssueController.sink
          .addError('Please select a country of issue');
    } else {
      countryOfIssueController.sink.add(countryOfIssue);
    }
  }

  Stream<bool> get isSubmittable {
    return Rx.combineLatest4(
      cardHolderNameStream,
      cardNumberStream,
      cvvStream,
      countryOfIssueStream,
      (a, b, c, d) => true,
    );
  }

  String inferCardType() {
    if (cardNumberController.value.startsWith(
      RegExp('^4[0-9]{4}(?:[0-9]{3})?'),
    )) {
      return 'visa';
    } else if (cardNumberController.value.startsWith(
      RegExp('^5[1-5][0-9]{14}'),
    )) {
      return 'mastercard';
    } else {
      return 'unknown';
    }
  }

  CreditCard onSubmit() {
    if (cardHolderNameController.value.isEmpty) {
      throw Exception('exception');
    } else {
      return CreditCard(
        cardHolderName: cardHolderNameController.value,
        creditCardNumber: cardNumberController.value,
        creditCardType: inferCardType(),
        cvvNumber: cvvController.value,
        countryOfIssuer: countryOfIssueController.value,
      );
    }
  }

  void dispose() {
    cardHolderNameController.close();
    cardNumberController.close();
    cvvController.close();
    countryOfIssueController.close();
  }

}
