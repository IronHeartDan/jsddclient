import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsddclient/calendar/calender.dart';

import '../classes.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class PaymentStatement extends StatefulWidget {
  final C_user c_user;
  final Payment payment;

  PaymentStatement({required this.c_user, required this.payment});

  @override
  _PaymentStatementState createState() => _PaymentStatementState(payment);
}

class _PaymentStatementState extends State<PaymentStatement> {
  Payment payment;
  List<Order> orders = [];
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  final today = new DateTime.now();
  late String month;

  _PaymentStatementState(this.payment);

  @override
  void initState() {
    month = months[int.parse(payment.number) - 1];
    getData();
    super.initState();
  }

  void getData() async {
    societyReference
        .doc(widget.c_user.S_id)
        .collection("Users")
        .doc(widget.c_user.U_id)
        .collection(today.year.toString())
        .doc(payment.number)
        .collection("MilkData")
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((element) {
        element["Orders"].asMap().forEach((index, order) {
          orders.add(new Order(
              int.parse(element.id),
              (order["O_Time"] as Timestamp).toDate().toString(),
              order['P_Name'],
              order['P_Price'],
              order['P_Quantity'],
              order['O_Total']));
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF02B3E8),
              const Color(0xFF1A55B3),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
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
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.only(bottom: 2.0, right: 2.0, top: 2.0),
                alignment: Alignment.center,
                icon: Icon(CupertinoIcons.back)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, top: 20.0),
            child: Text(
              "Delivery Statement",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 90.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(top: 25.0),
                height: 60.0,
                width: double.infinity,
                child: Text(
                  month,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 21.0,
                          fontWeight: FontWeight.w600)),
                )),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              height: 2.0,
              thickness: 1.0,
            ),
            Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF02B3E8),
                    const Color(0xFF1A55B3),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Bill Summary",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Text(
                    "Month's Total:",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: Text(
                    payment.ruppee,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Text(
                    "Status:",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: Text(
                    payment.paid ? "Paid" : "Unpaid",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: payment.paid ? Colors.black : Colors.red,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 5.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: payment.paid ? true : false,
                    child: Icon(
                      Icons.download,
                      color: Colors.deepPurpleAccent,
                    ),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              height: 2.0,
              thickness: 1.0,
            ),
            Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF02B3E8),
                    const Color(0xFF1A55B3),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Bill Detail",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  // Detail detail = details[index];
                  Order order = orders[index];
                  return Column(children: [
                    Card(
                      elevation: 3.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 5.0),
                                child: Text(
                                  order.index.toString(),
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(month,
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400))),
                              )
                            ]),
                            Text(order.P_Name,
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500))),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text('₹ ${order.O_Total}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}
