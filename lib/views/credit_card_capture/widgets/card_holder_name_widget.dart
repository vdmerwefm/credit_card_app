import 'package:credit_card/views/credit_card_capture/bloc/credit_card_capture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardHolderNameWidget extends StatefulWidget {
  const CardHolderNameWidget({super.key});

  @override
  State<CardHolderNameWidget> createState() => _CardHolderNameWidgetState();
}

class _CardHolderNameWidgetState extends State<CardHolderNameWidget> {
  @override
  Widget build(BuildContext context) {

    final cardHolderContext = context.read<CreditCardsCaptureBloc>();

    return StreamBuilder(
      stream: cardHolderContext.cardHolderNameStream,
      builder: (context, snapshot) {
        return TextFormField(
          textCapitalization: TextCapitalization.characters,
          onChanged: cardHolderContext.updateCardHolderName,
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            hintText: 'Card holder name',
            icon: const Icon(
              Icons.person_outline_rounded,
              size: 32,
            ),
          ),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
