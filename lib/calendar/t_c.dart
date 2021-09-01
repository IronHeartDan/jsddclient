import 'package:flutter/material.dart';

class TC extends StatefulWidget {
  TC({Key? key}) : super(key: key);

  @override
  _TCState createState() => _TCState();
}

class _TCState extends State<TC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("T&C"),
      ),
    );
  }
}
