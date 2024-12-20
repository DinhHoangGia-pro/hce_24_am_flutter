import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test1/CartScreen.dart';
import 'package:test1/ListProductSQL.dart';
import 'package:test1/LoginScreen.dart';
import 'package:test1/MyHttpOverrides.dart';

import 'package:test1/ListProduct.dart';
import 'package:test1/ListProductAPI.dart';
import 'package:test1/TestWidget.dart';

import 'package:test1/myWidget1.dart';
import 'package:test1/mybutton.dart';
import 'package:test1/models/Product.dart';

import 'package:path_provider/path_provider.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginScreen(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define pages for navigation
  final List<Widget> _pages = [
    /*ListProductAPI(),*/
    ListProductSQL(),
    /*ListProduct(),*/
    ListProductAPI(),
    /*TestWidget(),*/
    CartScreen()
  ];

  // Function to handle tab switching
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.network(
              'https://img.freepik.com/premium-vector/ho-chi-minh-city-vietnam-skyline-with-panorama-white-background-vector-illustration-business-travel-tourism-concept-with-modern-buildings-image-banner-web-site_596401-63.jpg?w=1060')),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
