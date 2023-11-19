import 'package:buy_me/models/add_creditCard_model.dart';
import 'package:buy_me/ui/payment_screen/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCreditCardModel());
    Get.lazyPut(() => PaymentController());
  }
}
