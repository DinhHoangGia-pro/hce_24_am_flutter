import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test1/MyHttpOverrides.dart';
import 'package:test1/cong2so.dart';
import 'package:test1/cong2so_stateful.dart';
import 'package:test1/myWidget1.dart';
import 'package:test1/mybutton.dart';

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xffb53f7a),
              ),
              child: Column(
                children: [
                  const ButtonSection(),
                  CongHaiSo_Stateful(),
                  CongHaiSo_Stateful(),
                ],
              ),
            )),
      )));
}
