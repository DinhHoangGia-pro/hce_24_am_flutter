import 'package:flutter/material.dart';
import 'package:test1/models/Product.dart';
import 'package:test1/ProductDetailAPI.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListProductAPI extends StatefulWidget {
  //List<Product> _lstproducts;

  ListProductAPI();

  @override
  ListProductAPIState createState() {
    return ListProductAPIState();
  }
}

//------------------------------

class ListProductAPIState extends State<ListProductAPI> {
  late Future<List<Product>> lstproducts;
  @override
  void initState() {
    super.initState();
    lstproducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      // Chuyển đổi JSON sang danh sách các đối tượng Product

      List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Bộ điều khiển TextField để tìm kiếm
  TextEditingController searchController = TextEditingController();

  // Hàm lọc sản phẩm dựa vào tiêu đề
  void filterProducts(String query) {
    List<Product> filteredList = products.where((phantu) {
      return phantu.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();

    setState(() {
      //lstproducts = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // Gọi hàm filter khi thay đổi giá trị trong ô tìm kiếm
                  filterProducts(value);
                },
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<Product>>(
          future: lstproducts,
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

              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xffcf83a9),
                ),
                child: GridView.builder(
                    itemCount: lst.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột là 2
                      childAspectRatio: 0.75, // Tỷ lệ chiều cao / chiều rộng
                      crossAxisSpacing: 10.0, // Khoảng cách giữa các cột
                      mainAxisSpacing: 10.0, // Khoảng cách giữa các hàng
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0, // Hiệu ứng đổ bóng cho sản phẩm
                        child: Column(
                          children: [
                            //Vung cua anh
                            //

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Hero(
                                  tag: "${lst[index].id}",
                                  child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ProductDetailAPI(
                                                  product: lst[index]))),
                                      child: Image.network(
                                        lst[index].image.toString(),
                                        fit: BoxFit
                                            .cover, // Đảm bảo hình ảnh phủ kín vùng
                                      )),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                lst[index].title.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow
                                    .ellipsis, // Cắt bớt text nếu quá dài
                              ),
                              subtitle: Text(
                                "\$${lst[index].price.toString()}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(Icons
                                  .shopping_cart_outlined), // Biểu tượng giỏ hàng
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }
          },
        ));
  }
}
