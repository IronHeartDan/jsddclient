// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jsddclient/calendar/calendar_screen.dart';
import 'package:jsddclient/screens/otp.dart';

final firebasefirestore = FirebaseFirestore.instance;
final userRef = firebasefirestore.collection("users");

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String? phoneno = null;
TextEditingController _controller = TextEditingController();
bool _validate = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your phoneNo.",
                ),
                controller: _controller,
                onChanged: (value) {
                  if (value.isNotEmpty && value.length == 10) {
                    setState(() {
                      _validate = true;
                      phoneno = value;
                    });
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await userRef.doc(phoneno).get().then((value) {
                    if (value.exists) {
                      print("Founded");
                      logUser();
                    } else {
                      print("Not found");
                    }
                    // ignore: invalid_return_type_for_catch_error
                  }).catchError((value) => {print(value)});
                },
                child: Text("Login")),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }

  void logUser() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => OTPScreen(
                  phone: _controller.text,
                )));
  }
}
