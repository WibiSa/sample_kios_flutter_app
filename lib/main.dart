import 'package:flutter/material.dart';
import 'package:kiosku_app/homepage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiosku',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomePage(),
    );
  }
}
