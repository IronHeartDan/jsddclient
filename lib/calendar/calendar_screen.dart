import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsddclient/calendar/viewOrders.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calender.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference societyReference =
    firebaseFirestore.collection("societies");

class CalendarScreen extends StatefulWidget {
  final C_user c_user;

  CalendarScreen(this.c_user);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();
CalendarFormat format = CalendarFormat.month;

class _CalendarScreenState extends State<CalendarScreen> {
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

  List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  List<int> calConList = [];
  double total = 0;
  int _selectedMonth = 1;
  int _offSet = 0;

  ItemScrollController scrollController = ItemScrollController();

  DateTime? today = DateUtils.dateOnly(DateTime.now());
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> live;

  @override
  void initState() {
    _selectedMonth = today!.month;
    watch();
    super.initState();
    Future.delayed(Duration.zero, () => _scrollTo());
  }

  _scrollTo() {
    scrollController.scrollTo(
        index: (_selectedMonth - 1), duration: Duration(milliseconds: 500));
  }

  void watch() async {
    live = await societyReference
        .doc(widget.c_user.S_id)
        .collection("Users")
        .doc(widget.c_user.U_id)
        .collection(today!.year.toString())
        .doc(_selectedMonth.toString())
        .collection("MilkData")
        .snapshots()
        .listen((event) {
      getData();
    });
  }

  void getData() async {
    total = 0;
    calConList = [];
    setState(() {});
    await societyReference
        .doc(widget.c_user.S_id)
        .collection("Users")
        .doc(widget.c_user.U_id)
        .collection(today!.year.toString())
        .doc(_selectedMonth.toString())
        .collection("MilkData")
        .get()
        .then((value) {
      int length = value.docs.length;
      value.docs.asMap().forEach((docIndex, element) {
        calConList.add(int.parse(element.id));
        element["Orders"].asMap().forEach((index, order) {
          total += double.parse('${order["O_Total"]}');
        });
        if (length == (docIndex + 1)) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          // padding: EdgeInsets.all(20),
          child: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Color(0xFF02B3E8),
            //         Color(0xFF1A55B3),
            //       ],
            //       begin: FractionalOffset(0.0, 0.0),
            //       end: FractionalOffset(1.0, 0.0),
            //       stops: [0.0, 1.0],
            //       tileMode: TileMode.clamp,
            //     ),
            //     borderRadius:
            //         BorderRadius.all(Radius.circular(20))),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        builder: (context) {
                          return YearPicker(
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              selectedDate: today!,
                              onChanged: (val) {
                                today = val;
                                setState(() {});
                                live.cancel();
                                watch();
                                Navigator.pop(context);
                              });
                        },
                        context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        today!.year.toString(),
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_drop_down_circle_sharp)
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 40,
                child: ScrollablePositionedList.builder(
                    itemScrollController: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedMonth = index + 1;
                            _offSet = DateUtils.firstDayOffset(
                                today!.year,
                                _selectedMonth,
                                MaterialLocalizations.of(context));
                            live.cancel();
                            watch();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMonth == index + 1
                                ? Colors.deepPurple
                                : Colors.blueGrey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          margin: EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          padding: EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 5),
                          child: Center(
                              child: Text(
                            months[index],
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blueGrey),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: [
                    Center(
                      child: Text(
                        days[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        days[1],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        days[2],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        days[3],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        days[4],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        days[5],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        days[6],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: GridView.builder(
                    itemCount:
                        DateUtils.getDaysInMonth(today!.year, _selectedMonth) +
                            _offSet,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return index < _offSet
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.grey,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                today = DateTime(today!.year, _selectedMonth,
                                    (index + 1 - _offSet));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewOrder(
                                              dateTime: today!,
                                              c_user: widget.c_user,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: calConList
                                          .contains((index + 1 - _offSet))
                                      ? Colors.green
                                      : today!.year > DateTime.now().year
                                          ? Colors.grey
                                          : today!.year < DateTime.now().year
                                              ? Colors.red
                                              : today!.year ==
                                                      DateTime.now().year
                                                  ? _selectedMonth ==
                                                          DateTime.now().month
                                                      ? ((index + 1 - _offSet) >
                                                              DateTime.now().day
                                                          ? Colors.grey
                                                          : Colors.red)
                                                      : _selectedMonth >
                                                              DateTime.now()
                                                                  .month
                                                          ? Colors.grey
                                                          : Colors.red
                                                  : Colors.red,
                                ),
                                child: Center(
                                    child: Text(
                                  (index + 1 - _offSet).toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.all(10.0),
          height: 50.0,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Colors.blue.shade800),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "MONTH TOTAL",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Text(
                total.toString(),
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ]))
    ]);
  }
}
