import 'package:flutter/foundation.dart';
import 'dart:convert';

class Product {
  String? image, image_url = "", title, description, category, name;
  final price;

  int size = 0;
  int id = 0;

  Product(
      {this.image = "",
      this.title = "",
      this.image_url = "",
      this.name = "",
      this.category = "",
      this.price = 0,
      this.description = "",
      this.size = 0,
      this.id = 0});

  //Product(this.id, this.name, this.description, this.price, this.image);

  static final columns = ["id", "name", "description", "price", "image"];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      size: 0,
      price: json['price'],
      image: json['image'],
      image_url: json['image_url'],
    );
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image
      };
}

List<Product> products = [
  Product(
    id: 1,
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_1.png",
  ),
  Product(
    id: 2,
    title: "Belt Bag",
    price: 234,
    size: 8,
    description: dummyText,
    image: "assets/images/bag_2.png",
  ),
  Product(
    id: 3,
    title: "Hang Top",
    price: 234,
    size: 10,
    description: dummyText,
    image: "assets/images/bag_3.png",
  ),
  Product(
    id: 4,
    title: "Old Fashion",
    price: 234,
    size: 11,
    description: dummyText,
    image: "assets/images/bag_4.png",
  ),
  Product(
    id: 5,
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_5.png",
  ),
  Product(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_6.png",
  ),
  Product(
    id: 7,
    title: "Túi vải bố",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag7.jpg",
  ),
  Product(
    id: 8,
    title: "Túi vải",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag8.jpg",
  ),
  Product(
    id: 9,
    title: "Túi đeo nữ Venu",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_9.png",
  ),
  Product(
    id: 10,
    title: "Túi đeo nữ Xì trum",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_10.png",
  ),
  Product(
    id: 11,
    title: "Túi đeo nữ Việt Tiến",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_11.png",
  ),
  Product(
    id: 12,
    title: "Túi đeo nữ Coop",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_12.png",
  ),
];

String dummyText = "Đây là sản phẩm tuyệt vời. Không thể tin được";
