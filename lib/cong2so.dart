import 'package:flutter/material.dart';

class CongHaiSo extends StatelessWidget {
  final TextEditingController txt1_controller = TextEditingController();
  final TextEditingController txt2_controller = TextEditingController();
  final TextEditingController txtkq_controller = TextEditingController();

  void cong2so() {
    final sothu1 = txt1_controller.text;
    final sothu2 = txt2_controller.text;
    try {
      int a = int.parse(sothu1);
      int b = int.parse(sothu2);
      int c = a + b;
      txtkq_controller.text = c.toString();
    } on Exception catch (e) {
      txtkq_controller.text = "";
    }
  }

  CongHaiSo([
    Key? key,
  ]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      TextField(
        controller: txt1_controller,
        decoration: InputDecoration(hintText: "Số thứ nhất"),
      ),
      SizedBox(
        height: 20,
      ),
      TextField(
        controller: txt2_controller,
        decoration: InputDecoration(hintText: "Số thứ hai"),
      ),
      SizedBox(
        height: 20,
      ),
      TextField(
        controller: txtkq_controller,
        decoration: InputDecoration(hintText: "Kết quả"),
      ),
      SizedBox(
        height: 20,
      ),
      ElevatedButton(onPressed: cong2so, child: Text("Cộng 2 số")),
    ]);
  }
}
