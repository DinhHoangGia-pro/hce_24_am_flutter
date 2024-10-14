import 'package:flutter/material.dart';
import 'package:test1/models/Product.dart';

class ProductDetail extends StatefulWidget {
  Product? _product;
  ProductDetail(this._product);

  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  Product? product;
  @override
  void initState() {
    product = widget._product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
            title: Image.network(
                'https://img.freepik.com/premium-vector/ho-chi-minh-city-vietnam-skyline-with-panorama-white-background-vector-illustration-business-travel-tourism-concept-with-modern-buildings-image-banner-web-site_596401-63.jpg?w=1060')),
        body: Text("Đây là trang detail"),
      )),
    ));
  }
}
