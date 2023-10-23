import 'package:credit_card/views/view_exports.dart';
import 'package:credit_card_api/credit_card_api.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDeleteCard extends StatelessWidget {
  const ConfirmDeleteCard({required this.creditCard, super.key});

  final CreditCard creditCard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreditCardsBloc(
        creditCardRepository: context.read<CreditCardRepository>(),
      ),
      child: BlocBuilder<CreditCardsBloc, CreditCardsState>(
        builder: (context, state) {
          return Center(
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.42,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/delete.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Are you sure you want to delete this card?',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilledButton(
                              onPressed: () {
                                context.read<CreditCardsBloc>().add(
                                      DeleteCreditCard(creditCard),
                                    );
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            )
                          ],
                        ),
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
