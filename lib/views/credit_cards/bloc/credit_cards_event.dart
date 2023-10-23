part of 'credit_cards_bloc.dart';

sealed class CreditCardsEvent extends Equatable {
  const CreditCardsEvent();

  @override
  List<Object> get props => [];
}

final class RequestCreditCards extends CreditCardsEvent {
  const RequestCreditCards();
}

final class DeleteCreditCard extends CreditCardsEvent {
  const DeleteCreditCard(this.creditCard);
  final CreditCard creditCard;

  @override
  List<Object> get props =>  [creditCard];
}
