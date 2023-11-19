import 'package:credit_card_form/credit_card_form.dart';

class AddCreditCardModel {
  String? id;
  String? cardNumber;
  String? cardHolderName;
  String? expiryDate;
  String? cvcNumber;
  CardType? cardType;

  AddCreditCardModel({
    this.id,
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.cvcNumber,
    this.cardType,
  });
}
