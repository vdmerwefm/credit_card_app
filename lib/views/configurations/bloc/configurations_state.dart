// ignore_for_file: must_be_immutable

part of 'configurations_bloc.dart';

enum BannedCountryStatus {
  bannedCountryInitial,
  bannedCountrySuccess,
  bannedCountryFailure
}

final class ConfigurationsState extends Equatable {
  ConfigurationsState({
    required this.country,
    this.bannedCountries = const [],
    this.status = BannedCountryStatus.bannedCountryInitial,
  });

  ConfigurationsState copyWith({
    BannedCountryStatus Function()? status,
    BannedCountry Function()? country,
    List<BannedCountry> Function()? bannedCountries,
  }) {
    return ConfigurationsState(
      status: status != null ? status() : this.status,
      country: country != null ? country() : this.country,
      bannedCountries:
          bannedCountries != null ? bannedCountries() : this.bannedCountries,
    );
  }

  final BannedCountryStatus status;
  final List<BannedCountry> bannedCountries;
  BannedCountry? country;

  @override
  List<Object?> get props => [
        status,
        bannedCountries,
      ];
}
