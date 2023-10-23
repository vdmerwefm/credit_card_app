import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'credit_card.g.dart';

typedef JsonMap = Map<String, dynamic>;

@immutable
@JsonSerializable()
class CreditCard extends Equatable {
  CreditCard({
    required this.cardHolderName,
    required this.creditCardNumber,
    required this.creditCardType,
    required this.cvvNumber,
    required this.countryOfIssuer,
    String? id,
  })  : assert(id == null || id.isNotEmpty, 'id must not be null or empty'),
        id = id ?? const Uuid().v4();

  factory CreditCard.fromJson(JsonMap json) => _$CreditCardFromJson(json);

  factory CreditCard.empty() => CreditCard(
        cardHolderName: '',
        creditCardNumber: '',
        creditCardType: '',
        cvvNumber: '',
        countryOfIssuer: '',
      );

  final String id;
  final String cardHolderName;
  final String creditCardNumber;
  final String creditCardType;
  final String cvvNumber;
  final String countryOfIssuer;

  CreditCard copyWith({
    String? id,
    String? cardHolderName,
    String? creditCardNumber,
    String? creditCardType,
    String? cvvNumber,
    String? countryOfIssuer,
  }) {
    return CreditCard(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      creditCardNumber: creditCardNumber ?? this.creditCardNumber,
      creditCardType: creditCardType ?? this.creditCardType,
      cvvNumber: cvvNumber ?? this.cvvNumber,
      countryOfIssuer: countryOfIssuer ?? this.countryOfIssuer,
    );
  }

  JsonMap toJson() => _$CreditCardToJson(this);

  @override
  List<Object?> get props => [
        id,
        cardHolderName,
        creditCardNumber,
        creditCardType,
        cvvNumber,
        countryOfIssuer,
      ];
}
