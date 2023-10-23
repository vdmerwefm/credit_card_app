part of 'credit_cards_bloc.dart';

enum CreditCardsStatus {
  creditCardInitial,
  creditCardsLoading,
  creditCardsLoaded,
  creditCardsError
}

final class CreditCardsState extends Equatable {
  const CreditCardsState({
    this.status = CreditCardsStatus.creditCardInitial,
    this.creditCards = const [],
    this.deleteCreditCard,
  });

  final CreditCardsStatus status;
  final List<CreditCard> creditCards;
  final CreditCard? deleteCreditCard;

  CreditCardsState copyWith({
    CreditCardsStatus Function()? status,
    List<CreditCard> Function()? creditCards,
    CreditCard? Function()? deleteCreditCard,
  }) {
    return CreditCardsState(
      status: status != null ? status() : this.status,
      creditCards: creditCards != null ? creditCards() : this.creditCards,
      deleteCreditCard:
          deleteCreditCard != null ? deleteCreditCard() : this.deleteCreditCard,
    );
  }

  @override
  List<Object?> get props => [
        status,
        creditCards,
        deleteCreditCard,
      ];
}
