import 'package:bloc/bloc.dart';
import 'package:credit_card_api/credit_card_api.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:equatable/equatable.dart';

part 'credit_cards_event.dart';
part 'credit_cards_state.dart';

class CreditCardsBloc extends Bloc<CreditCardsEvent, CreditCardsState> {
  CreditCardsBloc({required CreditCardRepository creditCardRepository})
      : _creditCardRepository = creditCardRepository,
        super(const CreditCardsState()) {
    on<RequestCreditCards>(onCreditCardsRequested);
    on<DeleteCreditCard>(_deleteCreditCard);
  }
  final CreditCardRepository _creditCardRepository;

  Future<void> onCreditCardsRequested(
    RequestCreditCards event,
    Emitter<CreditCardsState> emit,
  ) async {
    emit(state.copyWith(status: () => CreditCardsStatus.creditCardsLoading));
    await emit.forEach<List<CreditCard>>(
      _creditCardRepository.getCreditCards(),
      onData: (creditCards) => state.copyWith(
        status: () => CreditCardsStatus.creditCardsLoaded,
        creditCards: () => creditCards,
      ),
    );
  }

  Future<void> _deleteCreditCard(
    DeleteCreditCard event,
    Emitter<CreditCardsState> emit,
  ) async {
    emit(state.copyWith(deleteCreditCard: () => event.creditCard));
    await _creditCardRepository.deleteCreditCards(event.creditCard.id);
  }
}
