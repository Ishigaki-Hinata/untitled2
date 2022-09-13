import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
/*import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'dart:async';*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
          title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class Event {
  Event(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> event) {
    appointments = event;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
//カレンダーのイベント出力
List<Event> _getDataSource() {
  final List<Event> event = <Event>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);//今の年月日,時間
  final DateTime endTime = startTime.add(const Duration(hours: 2));//二時間分
  event.add(
      Event('イベント', startTime, endTime, const Color(0xFF0F8644), false));//イベント出力
  return event;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
        ],
      ),
      body: Center(
          child:SfCalendar(
            todayHighlightColor: Colors.red,
            allowedViews:const [CalendarView.month,CalendarView.week,CalendarView.day,],
            monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            dataSource: EventDataSource(_getDataSource()),
            onTap: (CalendarTapDetails details) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Container(
                        child: Text("${details.date}"),
                      ),
                      actions: <Widget>[
                        new TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'))
                      ],
                    );
                  });
            },
          ),
      ),
    );
  }
}

