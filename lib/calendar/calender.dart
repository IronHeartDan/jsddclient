// ignore_for_file: sized_box_for_whitespace

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsddclient/calendar/my_account.dart';
import 'package:jsddclient/calendar/payment_screen.dart';
import 'package:jsddclient/screens/about_us.dart';
import 'package:jsddclient/screens/faq.dart';
import 'package:jsddclient/screens/login.dart';
import 'package:jsddclient/screens/t_c.dart';

import 'calendar_screen.dart';

class C_user {
  String Name;
  String Phone;
  String S_id;
  String U_id;

  C_user(this.Name, this.Phone, this.S_id, this.U_id);
}

// ignore: use_key_in_widget_constructors
class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender>
    with SingleTickerProviderStateMixin {
  // CalendarFormat format = CalendarFormat.month;

  C_user c_user = new C_user("Name", "..........", "S_id", "U_id");

  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    getUser();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _scrollController = ScrollController();
    super.initState();
  }

  void getUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber?.substring(3))
        .get()
        .then((value) {
      print(value.exists);
      if (value.exists) {
        c_user = new C_user(
            value["Name"], value["Phone"], value["S_id"], value["U_id"]);
        setState(() {});
        print(c_user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[700],
      drawer: Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        width: MediaQuery.of(context).size.width / 1.5,
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
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
        ),
        child: Stack(children: [
          ListView(
            children: [
              DrawerHeader(
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        // make it responsive
                        margin: const EdgeInsets.only(top: 30.0),
                        height: 70.0,
                        width: 55.0,
                        // color: Colors.deepOrange,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset(
                          "images/dp.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hello ${c_user != null ? c_user.Name : '...'}",
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                "${c_user != null ? c_user.Phone.substring(0, 7) : '...'}xxx",
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600)),
                              )
                            ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Divider(
                    thickness: 3.0,
                    color: Colors.white,
                  )
                ]),
              ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MyAccount(c_user))),
                title: Text(
                  "My Account",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AboutUs())),
                title: Text(
                  "About us",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FAQ()));
                },
                title: Text(
                  "FAQ's",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TC())),
                title: Text(
                  "T & C",
                  // style: TextStyle(color: Colors.white, fontSize: 18.0),
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 100.0,
                  color: const Color.fromRGBO(255, 255, 255, 0.6),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Log Out",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      color: Color.fromRGBO(21, 107, 191, 1),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              height: 40.0,
                              width: 38.0,
                              child: Image.asset("images/forward.png",
                                  fit: BoxFit.cover),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(
                "images/bg.png",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.color,
              )),
          Container(
            height: double.infinity,
            width: double.infinity,
            // color: const Color.fromRGBO(0, 182, 233, 0.9),
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
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 20.0),
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset("images/nav.png")),
                );
              }),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 45.0),
                child: Text(
                  "JAN SHAKTI DUDH DEPO",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ]),
          Container(
              margin: const EdgeInsets.only(top: 90.0),
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28.0),
                      topRight: Radius.circular(28.0))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: Text(
                          "Hi ${c_user != null ? c_user.Name : '...'}",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    TabBar(
                      // indicator: UnderlineTabIndicator(
                      //     borderSide: BorderSide(
                      //         width: 4.0, color: Colors.blue.shade800),
                      //     insets: const EdgeInsets.symmetric(horizontal: 80.0)),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4.0,
                      indicatorColor: Colors.blue[800],
                      controller: _tabController,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Calendar",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        Text(
                          "Payment",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TabBarView(
                            controller: _tabController,
                            children: [
                              CalendarScreen(c_user),
                              PaymentScreen(c_user)
                            ]),
                      ),
                    ),
                  ]))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
