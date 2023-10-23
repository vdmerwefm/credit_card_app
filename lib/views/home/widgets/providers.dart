import 'package:banned_country_repo/banned_country_repo.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider<CreditCardsCaptureBloc>(
          create: (_) => CreditCardsCaptureBloc(
            creditCard: null,
            creditCardRepository: context.read<CreditCardRepository>(),
          ),
        ),
        BlocProvider<CreditCardsBloc>(
          create: (_) => CreditCardsBloc(
            creditCardRepository: context.read<CreditCardRepository>(),
          )..add(
              const RequestCreditCards(),
            ),
        ),
        BlocProvider<ConfigurationsBloc>(
          create: (_) => ConfigurationsBloc(
            bannedCountry: null,
            bannedCountryRepo: context.read<BannedCountryRepo>(),
          )..add(const RequestBannedCountries()),
        ),
      ],
      child: const HomeView(),
    );
  }
}
