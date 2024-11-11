import 'package:flutter/material.dart';
import 'package:test1/models/Product.dart';
import 'models/Cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailAPI extends StatefulWidget {
  Product product;

  //ProductDetail(this._product);

  ProductDetailAPI({Key? key, required this.product}) : super(key: key);

  @override
  ProductDetailAPIState createState() => ProductDetailAPIState();
}

//------------------------------

class ProductDetailAPIState extends State<ProductDetailAPI> {
  Product product = Product(image: '', title: '', description: '', size: 0);

  late Future<List<Product>> lstsanphamlienquan;

  Future<List<Product>> Laysanphamlienquantubackend(String catalog) async {
    final response = await http.get(Uri.parse(
        'https://6731c05f7aaf2a9aff11dd05.mockapi.io/products?category=' +
            catalog));

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
    product = widget.product;
    super.initState();
    lstsanphamlienquan =
        Laysanphamlienquantubackend(product.category.toString());
  }

  @override
  Widget build(BuildContext context) {
    // List<Product> relatedProducts =
    //     products.where((p) => p.id != product.id).toList();
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? "No Title"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.image ?? 'assets/default_image.png',
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                product.title ?? "No Title",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                "Mô Tả:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                product.description ?? "No description available",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Text(
                "Sản Phẩm Liên Quan:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Hiển thị sản phẩm liên quan
              //
              FutureBuilder<List<Product>>(
                  future: lstsanphamlienquan,
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
                        child: Container(
                          height:
                              200, // Đặt chiều cao cho danh sách các sản phẩm liên quan
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: lst.length,
                            itemBuilder: (BuildContext context, int index) {
                              Product relatedProduct = lst[index];
                              return GestureDetector(
                                onTap: () {
                                  // Điều hướng sang trang chi tiết sản phẩm khi nhấn vào sản phẩm liên quan
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailAPI(
                                          product: relatedProduct),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffebf0f2),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15.0)),
                                          child: Image.network(
                                            relatedProduct.image ??
                                                'assets/default_image.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          relatedProduct.title ?? "No Title",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }),

              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Thêm sản phẩm vào giỏ hàng
                    Cart.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} added to cart!'),
                      ),
                    );
                  },
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
