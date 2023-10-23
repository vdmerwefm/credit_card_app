import 'package:banned_country_repo/banned_country_repo.dart';
import 'package:credit_card/l10n/l10n.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:credit_card_repository/credit_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.creditCardRepository,
    required this.bannedCountryRepo,
    super.key,
  });

  final CreditCardRepository creditCardRepository;
  final BannedCountryRepo bannedCountryRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: creditCardRepository),
        RepositoryProvider.value(value: bannedCountryRepo)
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
