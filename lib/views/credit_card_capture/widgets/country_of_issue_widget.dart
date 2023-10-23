import 'package:banned_country_repo/banned_country_repo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryOfIssueWidget extends StatefulWidget {
  const CountryOfIssueWidget({super.key});

  @override
  State<CountryOfIssueWidget> createState() => _CountryOfIssueWidgetState();
}

class _CountryOfIssueWidgetState extends State<CountryOfIssueWidget> {
  late String _chosen;

  @override
  void initState() {
    super.initState();
    _chosen = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigurationsBloc>(
      create: (_) => ConfigurationsBloc(
        bannedCountryRepo: context.read<BannedCountryRepo>(),
        bannedCountry: null,
      )..add(const RequestBannedCountries()),
      child: BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
        builder: (context, state) {
          final countryOfIssueContext = context.read<CreditCardsCaptureBloc>();
          return StreamBuilder(
            stream: countryOfIssueContext.countryOfIssueStream,
            builder: (context, snapshot) {
              return Container(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                width: double.infinity,
                child: FilledButton(
                  child: !snapshot.hasData
                      ? const Text('select country of issue')
                      : Text(snapshot.data.toString()),
                  onPressed: () {
                    showCountryPicker(
                      searchAutofocus: true,
                      context: context,
                      countryListTheme: CountryListThemeData(
                        bottomSheetHeight:
                            MediaQuery.of(context).size.height*0.8,
                        inputDecoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                        ),
                      ),
                      onSelect: (value) {
                        countryOfIssueContext.updateCountryOfIssue(value.name);
                        setState(() {
                          _chosen = value.name;
                        });
                      },
                      exclude: state.bannedCountries
                          .map((e) => e.countryCode)
                          .toList(),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
