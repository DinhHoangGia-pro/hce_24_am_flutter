import 'package:test1/models/Item.dart';
import 'package:test1/models/Product.dart';
import 'dart:developer';

class Cart {
  static List<Item> cartItems = [];

  static void addToCart(Product product) {
    // Kiểm tra nếu sản phẩm đã có trong giỏ hàng
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++; // Tăng số lượng nếu sản phẩm đã có
    } else {
      log("Bắt đầu test");
      cartItems.add(Item(product: product, quantity: 1));
      log("Test cartItems:" + cartItems.length.toString());
    }
  }

  static void removeFromCart(int productID) {
    int index = cartItems.indexWhere((item) => item.product.id == productID);
    if (index != -1) {
      cartItems.remove(cartItems[index]);
    }
  }

  static double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total +=
          item.product.price * item.quantity; // Tính tổng dựa trên số lượng
    }
    return total;
  }
}
