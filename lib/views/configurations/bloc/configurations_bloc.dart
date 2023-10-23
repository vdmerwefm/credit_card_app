import 'package:banned_country_api/banned_country_api.dart';
import 'package:banned_country_repo/banned_country_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'configurations_event.dart';
part 'configurations_state.dart';

class ConfigurationsBloc
    extends Bloc<ConfigurationsEvent, ConfigurationsState> {
  ConfigurationsBloc({
    required BannedCountryRepo bannedCountryRepo,
    required BannedCountry? bannedCountry,
  })  : _bannedCountryRepo = bannedCountryRepo,
        super(
          ConfigurationsState(
            country: bannedCountry,
          ),
        ) {
    on<BanCountryEvent>(_banCountryRequested);
    on<RequestBannedCountries>(_bannedCountryList);
    on<UnbanCountryEvent>(_unban);
  }

  final BannedCountryRepo _bannedCountryRepo;


  Future<void> _banCountryRequested(
    BanCountryEvent event,
    Emitter<ConfigurationsState> emit,
  ) async {
    final banCountry = event.country;
    await _bannedCountryRepo.banCountry(banCountry);
  }

  Future<void> _unban(
    UnbanCountryEvent event,
    Emitter<ConfigurationsState> emit,
  ) async {
    final unbanCountry = event.country;
    await _bannedCountryRepo.unbanCountry(unbanCountry);
  }

  Future<void> _bannedCountryList(
    RequestBannedCountries event,
    Emitter<ConfigurationsState> emit,
  ) async {
    emit(
      state.copyWith(status: () => BannedCountryStatus.bannedCountrySuccess),
    );
    await emit.forEach<List<BannedCountry>>(
      _bannedCountryRepo.getBannedCountries(),
      onData: (bannedCountries) => state.copyWith(
        status: () => BannedCountryStatus.bannedCountrySuccess,
        bannedCountries: () => bannedCountries,
      ),
    );
  }
}
