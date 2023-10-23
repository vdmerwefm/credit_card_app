// ignore_for_file: must_be_immutable

import 'package:credit_card/views/credit_card_capture/bloc/credit_card_capture_bloc.dart';
import 'package:credit_card/views/credit_card_capture/widgets/card_holder_name_widget.dart';
import 'package:credit_card/views/credit_card_capture/widgets/card_number_widget.dart';
import 'package:credit_card/views/credit_card_capture/widgets/country_of_issue_widget.dart';
import 'package:credit_card/views/credit_card_capture/widgets/cvv_number_widget.dart';
import 'package:credit_card/views/credit_card_capture/widgets/submit_button_widget.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardCapture extends StatelessWidget {
  const CreditCardCapture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreditCardsCaptureBloc>(
      create: (_) => CreditCardsCaptureBloc(
        creditCardRepository: context.read<CreditCardRepository>(),
        creditCard: null,
      ),
      child: BlocBuilder<CreditCardsCaptureBloc, CreditCardCaptureState>(
        builder: (context, child) {
          return Center(
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black87,
                      title: const Text(
                        'Enter card details',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 24),
                      child: const Column(
                        children: [
                          CardHolderNameWidget(),
                          CardNumberWidget(),
                          CvvNumberWidget(),
                          CountryOfIssueWidget(),
                          SubmitButtonWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
