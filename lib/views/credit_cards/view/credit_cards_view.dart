import 'package:credit_card/views/credit_cards/widgets/credit_cards_list.dart';
import 'package:flutter/material.dart';

class CreditCardsPage extends StatelessWidget {
  const CreditCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Cardify',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 28,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 32, right: 32, top: 16),
        child: CreditCardsList(),
      ),
    );
  }
}
