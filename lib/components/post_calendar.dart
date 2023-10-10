import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class LoanData {
  final DateTime loanDate;
  final DateTime? returnDate;

  LoanData(this.loanDate, this.returnDate);
}

class PostCalendar extends StatefulWidget {
  const PostCalendar({super.key, required this.loanDate});
  //List<LoanData> loanDataList;
  final DateTime loanDate;

  @override
  State<PostCalendar> createState() => _PostCalendarState();
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class _PostCalendarState extends State<PostCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  List<DateTime> selectedDates = [];

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = widget.loanDate;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
