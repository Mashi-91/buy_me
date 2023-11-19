import 'package:buy_me/models/add_creditCard_model.dart';
import 'package:credit_card_form/credit_card_form.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  late final AddCreditCardModel addCreditCardModel;
  List<AddCreditCardModel> cardList = [];
  AddCreditCardModel? result;
  AddCreditCardModel? selectCard = AddCreditCardModel();

  @override
  void onInit() {
    super.onInit();
    addCreditCardModel = AddCreditCardModel();
  }

  void toggleSelectCard(AddCreditCardModel card){
    if(selectCard == card){
      selectCard = null;
      update();
    }else {
      selectCard = card;
      update();
    }
  }

  Future<void> getValue(CreditCardResult val) async {
    result = AddCreditCardModel(
      cardHolderName: val.cardHolderName,
      cardNumber: val.cardNumber,
      cardType: val.cardType,
      cvcNumber: val.cvc,
      expiryDate: "${val.expirationMonth}/${val.expirationYear}",
    );
    update();
  }

  Future<void> savedCard() async {
    cardList.add(result!);
    update();
  }

  String switchCardType(CardType cardType) {
    if (cardType == CardType.visa) {
      return "VISA";
    } else if (cardType == CardType.master) {
      return "MasterCard";
    }
    return 'OTHER';
  }

  String switchCardImage(CardType cardType) {
    if (cardType == CardType.visa) {
      return "assets/cardImages/visa.jpeg";
    } else if (cardType == CardType.master) {
      return "assets/cardImages/master.jpeg";
    }
    return "assets/cardImages/other.jpeg";
  }
}
