import 'package:credit_card/views/credit_card_capture/bloc/credit_card_capture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CvvNumberWidget extends StatefulWidget {
  const CvvNumberWidget({super.key});

  @override
  State<CvvNumberWidget> createState() => _CvvNumberWidgetState();
}

class _CvvNumberWidgetState extends State<CvvNumberWidget> {
  @override
  Widget build(BuildContext context) {
    final cvvContext = context.read<CreditCardsCaptureBloc>();
    return StreamBuilder(
      stream: cvvContext.cvvStream,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged:cvvContext.updateCVV,
          maxLength: 3,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'CVV',
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            icon: const Icon(
              Icons.password_rounded,
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
