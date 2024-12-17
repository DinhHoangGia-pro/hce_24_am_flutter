import 'package:flutter/material.dart';
import 'models/Product.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final Function(Product) onSubmit;

  ProductForm({this.product, required this.onSubmit});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers cho tất cả các trường
  late TextEditingController _titleController;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _sizeController;
  late TextEditingController _imageController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controllers với giá trị từ product nếu có
    _titleController = TextEditingController(text: widget.product?.title ?? '');
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _categoryController =
        TextEditingController(text: widget.product?.category ?? '');
    _sizeController =
        TextEditingController(text: widget.product?.size.toString() ?? '');
    _imageController = TextEditingController(text: widget.product?.image ?? '');
    _imageUrlController =
        TextEditingController(text: widget.product?.image_url ?? '');
  }

  @override
  void dispose() {
    // Giải phóng controllers
    _titleController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _sizeController.dispose();
    _imageController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Thêm sản phẩm' : 'Sửa sản phẩm'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Tiêu đề'),
                  validator: (value) =>
                      value!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Giá sản phẩm'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Vui lòng nhập giá sản phẩm' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Mô tả'),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Danh mục'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _sizeController,
                  decoration: InputDecoration(labelText: 'Kích thước'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: InputDecoration(labelText: 'Đường dẫn ảnh local'),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final product = Product(
                        id: widget.product?.id ?? 0,
                        title: _titleController.text,
                        price: double.tryParse(_priceController.text) ?? 0.0,
                        description: _descriptionController.text,
                        category: _categoryController.text,
                        size: int.tryParse(_sizeController.text) ?? 0,
                        image: _imageController.text,
                      );
                      widget.onSubmit(product);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.product == null ? 'Thêm' : 'Cập nhật'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
