import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test1/MyHttpOverrides.dart';
import 'package:test1/cong2so.dart';
import 'package:test1/cong2so_stateful.dart';
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
            body: Container(
              margin: EdgeInsets.all(10.0),
              transform: Matrix4.rotationZ(0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffcf83a9),
              ),
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 250,
                      color: Color(0xffd5e0e8),
                      child: Column(children: [
                        Expanded(
                            child: Container(
                                child: Hero(
                                    tag: "${products[index].id}",
                                    child: Image.asset(
                                        products[index].image.toString())))),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Text(products[index].title.toString())
                      ]),
                    );
                  }),
            )),
      )));
}
