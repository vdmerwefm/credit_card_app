import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

typedef JsonMap = Map<String, dynamic>;

@immutable
@JsonSerializable()
class BannedCountry extends Equatable {
  const BannedCountry({required this.country, required this.countryCode});

  factory BannedCountry.fromJson(JsonMap json) => BannedCountry(
        country: json['country'] as String,
        countryCode: json['countryCode'] as String,
      );

  final String country;
  final String countryCode;

  BannedCountry copyWith({String? country, String? countryCode}) {
    return BannedCountry(
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  JsonMap toJson() {
    return {
      'country': country,
      'countryCode' : countryCode
    };
  }

  @override
  List<Object?> get props => [
        country,
        countryCode,
      ];
}
