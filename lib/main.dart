import 'package:flutter/material.dart';

import 'Home.dart';

void main() => runApp(ChuckNorris());

class ChuckNorris extends StatefulWidget {
  @override
  ChuckNorrisState createState() => ChuckNorrisState();
}

class ChuckNorrisState extends State<ChuckNorris> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
