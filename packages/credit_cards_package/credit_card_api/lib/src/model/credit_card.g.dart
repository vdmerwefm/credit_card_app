// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) => CreditCard(
      cardHolderName: json['cardHolderName'] as String,
      creditCardNumber: json['creditCardNumber'] as String,
      creditCardType: json['creditCardType'] as String,
      cvvNumber: json['cvvNumber'] as String,
      countryOfIssuer: json['countryOfIssuer'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardHolderName': instance.cardHolderName,
      'creditCardNumber': instance.creditCardNumber,
      'creditCardType': instance.creditCardType,
      'cvvNumber': instance.cvvNumber,
      'countryOfIssuer': instance.countryOfIssuer,
    };
