import 'package:flutter/material.dart';
import 'models/User.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> users = User.getUsers();

    return Scaffold(
      appBar: AppBar(title: Text('Tài Khoản')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
          );
        },
      ),
    );
  }
}
