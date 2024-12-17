import 'package:test1/models/Product.dart';

class Item {
  Product product;
  int quantity;

  Item({required this.product, this.quantity = 1});
}
