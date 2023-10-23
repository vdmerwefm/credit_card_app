import 'package:credit_card/views/credit_card_capture/bloc/credit_card_capture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardNumberWidget extends StatefulWidget {
  const CardNumberWidget({super.key});

  @override
  State<CardNumberWidget> createState() => _CardNumberWidgetState();
}

class _CardNumberWidgetState extends State<CardNumberWidget> {
  @override
  Widget build(BuildContext context) {
    final cardNumberContext = context.read<CreditCardsCaptureBloc>();

    return StreamBuilder(
      stream: cardNumberContext.cardNumberStream,
      builder: (context, snapshot) {
        return TextField(
          onChanged:cardNumberContext.updateCardNumber,
          maxLength: 16,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            hintText: 'Card number',
            icon: const Icon(
              Icons.credit_score_rounded,
              size: 32,
            ),
            counterText: '',
          ),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

}
