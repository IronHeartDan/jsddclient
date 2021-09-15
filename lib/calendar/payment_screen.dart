import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsddclient/calendar/calender.dart';
import 'package:jsddclient/calendar/payment_statement.dart';

import '../classes.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class PaymentScreen extends StatefulWidget {
  final C_user c_user;

  PaymentScreen(this.c_user);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(c_user);
}

class _PaymentScreenState extends State<PaymentScreen> {
  final C_user c_user;

  _PaymentScreenState(this.c_user);

  final today = new DateTime.now();

  List<Payment> payments = [];

  bool s_state = false;

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

  @override
  void initState() {
    // watch();
    getData();
    super.initState();
  }

  // void watch() {
  //   societyReference
  //       .doc(c_user.S_id)
  //       .collection("Users")
  //       .doc(c_user.U_id)
  //       .collection(today.year.toString())
  //       .snapshots()
  //       .listen((event) {
  //     getData();
  //   });
  // }

  void getData() async {
    print("S :${c_user.S_id}, U :${c_user.U_id}, T :${today.year}");
    payments = [];
    await societyReference
        .doc(c_user.S_id)
        .collection("Users")
        .doc(c_user.U_id)
        .collection(today.year.toString())
        .get()
        .then((value) {
      print(value.docs.length);
      value.docs.forEach((element) {
        if (DateTime.now().month != int.parse(element.id)) {
          payments.add(new Payment(months[int.parse(element.id) - 1],
              element['M_Total'].toString(), element['Paid'], element.id));
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: payments.length,
      itemBuilder: (BuildContext context, int index) {
        Payment payment = payments[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PaymentStatement(
                          c_user: c_user,
                          payment: payment,
                        )));
          },
          child: Card(
            margin: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
                height: 74.0,
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: (index % 2 == 0)
                        ? const LinearGradient(
                            colors: [
                              const Color(0xFF02B3E8),
                              const Color(0xFF1A55B3),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          )
                        : const LinearGradient(
                            colors: [Color(0XFFFFFFFF), Color(0xFFFFFFFF)],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(payment.date,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Color.fromRGBO(2, 179, 232, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500))),
                        Text("Total : ₹ ${payment.ruppee}",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Color.fromRGBO(2, 179, 232, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(payment.paid ? "Paid" : "Unpaid",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Color.fromRGBO(2, 179, 232, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500))),
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
