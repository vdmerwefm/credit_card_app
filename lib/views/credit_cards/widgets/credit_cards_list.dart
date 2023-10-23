import 'package:credit_card/views/credit_cards/widgets/confirm_delete_card.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardsList extends StatelessWidget {
  const CreditCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CreditCardsBloc, CreditCardsState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.creditCards.length,
              itemBuilder: (context, index) {
                final card = state.creditCards[index];
                final cardType = state.creditCards[index].creditCardType;
                String cardImage;
                if (cardType == 'visa') {
                  cardImage = 'assets/images/visaImage.png';
                } else if (cardType == 'mastercard') {
                  cardImage = 'assets/images/mastercardImage.png';
                } else {
                  cardImage = 'assets/images/unknown.png';
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Card(
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(cardImage),
                      ),
                      title: Text(card.cardHolderName),
                      subtitle: Text(
                        card.creditCardNumber
                            .replaceRange(0, 14, 'card ending in  XX'),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return ConfirmDeleteCard(
                                creditCard: state.creditCards[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
