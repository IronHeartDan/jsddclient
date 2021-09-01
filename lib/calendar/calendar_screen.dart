import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();
CalendarFormat format = CalendarFormat.month;

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(
              top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            // color: Color.fromRGBO(2, 179, 232, 1.0),
            gradient: const LinearGradient(
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
          child: TableCalendar(
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              weekendStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: format,
            focusedDay: selectedDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
            },
            calendarStyle: const CalendarStyle(
                outsideTextStyle: TextStyle(color: Colors.black),
                defaultTextStyle: TextStyle(
                    color: Colors.black38, fontWeight: FontWeight.bold),
                selectedTextStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                weekendTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                isTodayHighlighted: true,
                selectedDecoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color: Colors.deepOrange, shape: BoxShape.circle)),
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(
                  CupertinoIcons.back,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  CupertinoIcons.forward,
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        // make it responsive
        Container(
            margin: const EdgeInsets.only(left: 18.0, right: 18.0),
            height: 50.0,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.blue.shade800),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      "₹100000",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ]))
      ]),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
}
