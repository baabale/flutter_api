import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/user.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<User>> getUsers() async {
    List<User> users = [];

    try {
      http.Response response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        for (var item in data) {
          User user = User.fromJson(item);
          users.add(user);
        }
      } else {
        print('Something went wrong | STATUS CODE: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: FutureBuilder<List<User>>(
        future: getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(users[index].name),
                  subtitle: Text(
                    users[index].email,
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
