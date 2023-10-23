import 'package:banned_country_api/banned_country_api.dart';
import 'package:country_picker/country_picker.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FabButton extends StatelessWidget {
  const FabButton({
    required this.groupValue,
    required this.value,
    required this.child,
    super.key,
  });

  final HomeTab groupValue;
  final HomeFab value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (context.read<HomeCubit>().state.tab == HomeTab.creditCards) {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const CreditCardCapture();
            },
          );
        },
        elevation: 0,
        child: child,
      );
    } else {
      return BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () => showCountryPicker(
              searchAutofocus: true,
              context: context,
              countryListTheme:  CountryListThemeData(
                bottomSheetHeight:
                            MediaQuery.of(context).size.height*0.8,
                inputDecoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                ),
              ),
              onSelect: (value) {
                final newCountry = BannedCountry(
                  country: value.name,
                  countryCode: value.countryCode,
                );
                context
                    .read<ConfigurationsBloc>()
                    .add(BanCountryEvent(country: newCountry));
              },
              exclude: state.bannedCountries.map((e) => e.countryCode).toList(),
            ),
            elevation: 0,
            child: child,
          );
        },
      );
    }
  }
}
