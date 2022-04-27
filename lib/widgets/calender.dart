import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/utils/pallete.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  void initState() {
    super.initState();
  }

  // DateTime? _selectedDay;
  final DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Palette.kToDark,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: GoogleFonts.lora(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          // selectedBuilder: (context, date, events) => Container(
          //   margin: const EdgeInsets.all(5.0),
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     color: Colors.black54,
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   child: Text(
          //     date.day.toString(),
          //     style: GoogleFonts.lora(
          //       fontSize: 24,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ),
        daysOfWeekHeight: 25,
        weekendDays: const [DateTime.sunday],
        calendarFormat: CalendarFormat.week,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        // onDaySelected: (selectedDay, focusedDay) {
        //   setState(() {
        //     _selectedDay = selectedDay;
        //     _focusedDay = focusedDay;
        //   });
        // },
        // selectedDayPredicate: (day) {
        //   return isSameDay(day, _selectedDay);
        // },
        headerStyle: HeaderStyle(
          headerPadding: const EdgeInsets.only(top: 35, bottom: 10),
          titleCentered: true,
          titleTextStyle: GoogleFonts.lora(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 25,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 25,
          ),
          formatButtonVisible: false,
          decoration: BoxDecoration(
            color: Palette.kToDark,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
            color: Palette.kToDark,
          ),
        ),
      ),
    );
  }
}
