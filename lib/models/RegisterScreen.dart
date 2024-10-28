import 'package:flutter/material.dart';
import 'models/User.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  void register() {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      User newUser = User(name: name, email: email, password: password);
      User.addUser(newUser);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      setState(() {
        errorMessage = 'Vui lòng điền đầy đủ thông tin';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tên'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}
