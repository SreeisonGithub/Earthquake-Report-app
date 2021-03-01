import 'package:earthquake/models/model.dart';
import 'package:earthquake/repository/api_provider.dart';
import 'package:flutter/material.dart';

Map quakes;
List features = [];
var bullshit;
void main() async {
  quakes = await ProductApi().fetchProducts();
  features.add(quakes['features']);
  bullshit = Products.fromJson(quakes['features']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    print(bullshit.toString());
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Text('hello'),
    )));
  }
}
