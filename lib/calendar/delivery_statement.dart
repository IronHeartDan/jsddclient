import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsddclient/data/data.dart';

class DeliveryStatement extends StatefulWidget {
  const DeliveryStatement({Key? key}) : super(key: key);

  @override
  _DeliveryStatementState createState() => _DeliveryStatementState();
}

class _DeliveryStatementState extends State<DeliveryStatement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
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
            margin: const EdgeInsets.only(left: 20.0, top: 23.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding:
                    const EdgeInsets.only(bottom: 2.0, right: 2.0, top: 2.0),
                alignment: Alignment.center,
                icon: Icon(CupertinoIcons.back)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, top: 24.0),
            child: Text(
              "Delivery Statement",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
      Container(
        margin: const EdgeInsets.only(top: 90.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding:const EdgeInsets.only(top: 25.0),
                height: 60.0,
                width: double.infinity,
                child: Text(
                  "01 JULY 2021",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 21.0,
                          fontWeight: FontWeight.w600)),
                )),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              height: 2.0,
              thickness: 1.0,
            ),
            Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                     Color(0xFF02B3E8),
                     Color(0xFF1A55B3),
                  ],
                  begin:  FractionalOffset(0.0, 0.0),
                  end:  FractionalOffset(1.0, 0.0),
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
                      textStyle:const  TextStyle(
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
                        textStyle:const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: Text(
                    "Rs 20000",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
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
                    "PAID",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.black,
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
                  child: Icon(
                    Icons.download,
                    color: Colors.deepPurpleAccent,
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
                itemCount: detail.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  Detail details = detail[index];
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
                                  details.date,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(details.months,
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400))),
                              )
                            ]),
                            Text(details.milk,
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500))),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text('₹ ${details.ruppee}',
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
