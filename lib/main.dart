import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_recipes_app/utilities/hex_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];

  void readJson() async {
    Response response = await get(Uri.parse("https://raw.githubusercontent.com/ababicheva/FlutterInternshipTestTask/main/recipes.json"));
    final data = await json.decode(response.body);
    setState(() {
      _items = data;
    });
  }
  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("6200ee"),
        title: Text("My Recipes"),
        actions: [
          Row(
            children: [
              Icon(
                Icons.search,
                size: 30.0,
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_items.length > 0)
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    leading: Image.network(
                      _items[index]["picture"],
                      width: 100,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                    title: Text(_items[index]["name"]),
                    subtitle: Text(_items[index]["description"]),
                    trailing: Text("0" + _items[index]["id"].toString(), style: TextStyle(color: HexColor("989898")),),
                  );
                },
              ),
            )
          else
            Container()
        ],
      ),
    );
  }
}
