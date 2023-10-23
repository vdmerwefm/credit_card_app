import 'package:credit_card/views/home/widgets/fab_button.dart';
import 'package:credit_card/views/view_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [CreditCardsPage(), ConfigurationPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: IndexedStack(
        index: selectedTab.index,
        children: [
          FabButton(
            groupValue: selectedTab,
            value: HomeFab.scanCardFab,
            child: const Icon(Icons.add_card),
          ),
          FabButton(
            groupValue: selectedTab,
            value: HomeFab.banCountryFab,
            child: const Icon(Icons.location_disabled_rounded),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        height: 80,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TabButton(
              groupValue: selectedTab,
              value: HomeTab.creditCards,
              icon: const Icon(
                Icons.credit_card,
                size: 32,
              ),
            ),
            TabButton(
              groupValue: selectedTab,
              value: HomeTab.configuration,
              icon: const Icon(
                Icons.settings_applications,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
