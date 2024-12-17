import 'package:flutter/material.dart';
import 'package:test1/MyCrypto.dart';

class HashingScreen extends StatefulWidget {
  @override
  _HasingState createState() => _HasingState();
}

class _HasingState extends State<HashingScreen> {
  final TextEditingController txtController = TextEditingController();
  final TextEditingController txthashController = TextEditingController();

  void TestHambam() {
    txthashController.text = MyCrypto.hashText(txtController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: txtController,
            decoration: InputDecoration(labelText: 'Nhập chuỗi text'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: txthashController,
            decoration: InputDecoration(labelText: 'Chuỗi băm'),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: TestHambam,
            child: Text('Login'),
          )
        ],
      ),
    );
  }
}
