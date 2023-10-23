part of 'credit_card_capture_bloc.dart';

sealed class CaptureEvent extends Equatable {
  const CaptureEvent();

  @override
  List<Object> get props => [];
}

final class CreditCardCaptureEvent extends CaptureEvent {
  const CreditCardCaptureEvent({
    required this.captureCreditCard,
    
  });
  final CreditCard captureCreditCard;
 

  @override
  List<Object> get props => [captureCreditCard];
}
