import 'package:flutter/material.dart';
import 'package:test1/models/Product.dart';
import 'package:http/http.dart' as http; /*Kết nối backend*/
import 'dart:convert'; /*Làm việc với json*/

class TestWidget extends StatefulWidget {
  TestWidget();

  @override
  TestWidgetState createState() {
    return TestWidgetState();
  }
}

class TestWidgetState extends State<TestWidget> {
  /*Danh sach san pham khoi tao trong tương lai*/
  late Future<List<Product>> dssanpham;

  Future<List<Product>> Laydulieutubackend() async {
    final response =
        await http.get(Uri.parse('https://fake-coffee-api.vercel.app/api'));

    if (response.statusCode == 200) {
      // Chuyển đổi JSON sang danh sách các đối tượng Product

      List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    dssanpham = Laydulieutubackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Product>>(
      future: dssanpham,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Lỗi:' + snapshot.error.toString()),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Không có dữ liệu'),
          );
        } else {
          List<Product> lst = snapshot.data!;
          return Center(
              child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: lst.length,
            itemBuilder: (context, index) {
              Product sp = lst[index];

              return Column(
                children: [
                  Image.network(sp.image_url.toString()),
                  Text(sp.name.toString()),
                ],
              );
            },
          ));
        }
      },
    ));
  }
}
