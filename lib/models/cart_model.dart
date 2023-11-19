import 'package:buy_me/models/shoe_model.dart';

class CartModel {
  final int? id;
  final ShoeModel shoeModel;
  int quantity;

  CartModel({this.id, required this.shoeModel, this.quantity = 1});
}
