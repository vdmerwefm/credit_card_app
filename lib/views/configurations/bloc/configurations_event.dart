part of 'configurations_bloc.dart';

sealed class ConfigurationsEvent extends Equatable {
  const ConfigurationsEvent();

  @override
  List<Object> get props => [];
}

final class BanCountryEvent extends ConfigurationsEvent {
  const BanCountryEvent({
    required this.country,
  });

  final BannedCountry country;

  @override
  List<Object> get props => [
        country,
      ];
}

final class UnbanCountryEvent extends ConfigurationsEvent {
  const UnbanCountryEvent(this.country);

  final BannedCountry country;

  @override
  List<Object> get props => [
        country,
      ];
}

final class RequestBannedCountries extends ConfigurationsEvent {
  const RequestBannedCountries();
}
