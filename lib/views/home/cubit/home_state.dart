part of 'home_cubit.dart';

enum HomeTab { creditCards, configuration }

enum HomeFab { scanCardFab, banCountryFab }

final class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.creditCards,
    this.fab = HomeFab.scanCardFab,
  });

  final HomeTab tab;
  final HomeFab fab;

  @override
  List<Object?> get props => [
        tab,
        fab,
      ];
}
