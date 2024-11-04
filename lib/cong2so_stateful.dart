import 'package:flutter/material.dart';

class CongHaiSo_Stateful extends StatefulWidget {
  int ketqua = 0;

  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<CongHaiSo_Stateful> {
  int kq = 0;
  TextEditingController txt1_controller = TextEditingController();
  TextEditingController txt2_controller = TextEditingController();

  @override
  void initState() {
    kq = widget.ketqua;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: txt1_controller,
          decoration: InputDecoration(hintText: "Số thứ nhất"),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        TextField(
          controller: txt2_controller,
          decoration: InputDecoration(hintText: "Số thứ hai"),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        Text(kq.toString(),
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange)),
        ElevatedButton(
          onPressed: cong2so,
          child: Text("Cộng 2 số"),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.limeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        )
      ],
    );
  }

  //-----------
  void cong2so() {
    final sothu1 = txt1_controller.text;
    final sothu2 = txt2_controller.text;
    int c = 0;

    try {
      int a = int.parse(sothu1);
      int b = int.parse(sothu2);
      c = a + b;
    } on Exception catch (e) {}
    setState(() {
      kq = c;
    });
  }
}
