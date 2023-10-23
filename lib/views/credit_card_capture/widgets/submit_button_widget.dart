import 'package:credit_card/views/credit_card_capture/bloc/credit_card_capture_bloc.dart';
import 'package:credit_card/views/credit_card_capture/widgets/scan_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ScanCardWidget(),
        StreamBuilder(
          stream:
              BlocProvider.of<CreditCardsCaptureBloc>(context).isSubmittable,
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              return Container(
                padding: const EdgeInsets.only(left: 8),
                child: FilledButton(
                  onPressed: () {
                    context.read<CreditCardsCaptureBloc>().add(
                          CreditCardCaptureEvent(
                              captureCreditCard:
                                  BlocProvider.of<CreditCardsCaptureBloc>(
                                          context)
                                      .onSubmit()),
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.only(left: 8),
                child: const FilledButton(
                  onPressed: null,
                  child: Text('Submit'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
