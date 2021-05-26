import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'models/users.dart';

Future<List<User>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new User.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Users Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? UsersList(users: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  final List<User> users;

  UsersList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 75,
          color: Colors.white,
          child: Card(
            child: ListTile(
              leading: Text(users[index].id.toString()),
              title: Text(users[index].name),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      _buildPopupDialog(context, users[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context, User user) {
    return new AlertDialog(
      title: const Text('User Details'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("id: ${user.id}"),
          Text("name: ${user.name}"),
          Text("username: ${user.name}"),
          Text("email: ${user.email}"),
          Text("address: ${user.address.city}, ${user.address.street}"),
          Text("phone: ${user.phone}"),
          Text("website: ${user.website}"),
          Text("Company: ${user.company.name}"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
