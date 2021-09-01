import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("My Account"),
      //   backgroundColor: Color.fromRGBO(2, 179, 232, 1.0),
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF02B3E8),
                    Color(0xFF1A55B3),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 35.0,
                  width: 35.0,
                  margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.only(
                          bottom: 2.0, right: 2.0, top: 2.0),
                      alignment: Alignment.center,
                      icon: const Icon(CupertinoIcons.back)),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 35.0, top: 20.0),
                  child: Text(
                    "My Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.only(top: 90.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 60.0),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.asset("images/dp.png"),
                    ),
                    const SizedBox(
                      height: 55.0,
                    ),
                    Text(
                      "Hi Rahul",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ListTile(
                      title: Text(
                        "LOCATION",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.blue[600],
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700)),
                      ),
                      leading: Container(
                          height: 25.0,
                          width: 25.0,
                          child: Image.asset("images/location.png")),
                    ),
                    ListTile(
                      title: Text(
                        "CONTACT NO.",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.blue[600],
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700)),
                      ),
                      leading: Container(
                          height: 25.0,
                          width: 25.0,
                          child: Image.asset("images/contact.png")),
                    ),
                    ListTile(
                      title: Text(
                        "MAIL ID",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.blue[600],
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700)),
                      ),
                      leading: Container(
                          height: 25.0,
                          width: 25.0,
                          child: Image.asset("images/mail.png")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
