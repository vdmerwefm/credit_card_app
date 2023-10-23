// ignore_for_file: must_be_immutable

part of 'credit_card_capture_bloc.dart';

enum CaptureCardStatus {
  captureCardInitial,
  captureInProgress,
  captureSuccess,
  captureFailure,
}

final class CreditCardCaptureState extends Equatable {
  CreditCardCaptureState({
    required this.creditCard,
    this.status = CaptureCardStatus.captureCardInitial,
  });

  final CaptureCardStatus status;
  CreditCard? creditCard;

  @override
  List<Object?> get props => [
        status,
        creditCard,
      ];
}
