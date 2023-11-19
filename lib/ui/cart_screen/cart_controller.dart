import 'dart:developer';

import 'package:buy_me/const/utils/utils.dart';
import 'package:buy_me/models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<CartModel> cartList = [];
  int count = 1;

  void addToCart({required CartModel cartModel}) {
    bool isItemExist = cartList.any((item) => item.id == cartModel.id);

    if (!isItemExist) {
      cartList.add(cartModel);
      Utils.snackBar(
          title: 'Add to Cart', msg: 'Your item has been saved in Cart :)');
    } else {
      Utils.snackBar(
          title: 'Add to Cart', msg: 'Your item already saved in Cart :)');
    }
    update();
  }

  int get countCart => cartList.length;

  void removeItem(index) {
    cartList.removeAt(index);
    Utils.snackBar(
        title: 'Remove from Cart', msg: 'Your item has been remove from Cart!');
    update();
  }

  void checkOut() {
    cartList = [];
    Utils.snackBar(title: 'Checkout', msg: 'Your order has been placed :)');
    update();
  }

  double totalPrice() {
    double totalPrice = 0.0;
    for (final cartItem in cartList) {
      totalPrice += cartItem.shoeModel.price * count;
    }
    return totalPrice;
  }

  void increment() {
    count++;
    update();
  }

  void decrement() {
    if (count > 1) count--;
    update();
  }
}
