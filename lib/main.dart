import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test1/MyHttpOverrides.dart';
import 'package:test1/ProductDetail.dart';
import 'package:test1/cong2so.dart';
import 'package:test1/cong2so_stateful.dart';
import 'package:test1/ListProduct.dart';
import 'package:test1/myWidget1.dart';
import 'package:test1/mybutton.dart';
import 'package:test1/models/Product.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Image.network(
                    'https://img.freepik.com/premium-vector/ho-chi-minh-city-vietnam-skyline-with-panorama-white-background-vector-illustration-business-travel-tourism-concept-with-modern-buildings-image-banner-web-site_596401-63.jpg?w=1060')),

            // Thay ListView.builder bằng GridView.builder
            body: ListProduct()),
      )));
}
