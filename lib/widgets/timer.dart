import 'dart:async';
import 'package:flutter/material.dart';



class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  Timer? _timer;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _getTimeUntil6pm() {
    final now = DateTime.now();
    final sixPm = DateTime(now.year, now.month, now.day, 18, 0, 0);
    return sixPm.isBefore(now) ? sixPm.add(Duration(days: 1)).difference(now) : sixPm.difference(now);
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      final remainingDuration = _getTimeUntil6pm();
      if (remainingDuration.inSeconds <= 0) {
        timer.cancel();
        _startNextDayTimer();
      } else {
        setState(() {
          _hours = remainingDuration.inHours;
          _minutes = remainingDuration.inMinutes.remainder(60);
          _seconds = remainingDuration.inSeconds.remainder(60);
        });
      }
    });
  }

  void _startNextDayTimer() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 9, 0, 0);
    final remainingDuration = tomorrow.difference(now);
    setState(() {
      _hours = remainingDuration.inHours;
      _minutes = remainingDuration.inMinutes.remainder(60);
      _seconds = remainingDuration.inSeconds.remainder(60);
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Timer App'),
      ),
      body: Center(
        child: Row(
          children: [
            CircularTimerWidget(label: 'Hours', value: _hours.toString().padLeft(2, '0')),
            CircularTimerWidget(label: 'Minutes', value: _minutes.toString().padLeft(2, '0')),
            CircularTimerWidget(label: 'Seconds', value: _seconds.toString().padLeft(2, '0')),
          ],
        ),
      ),
    );
  }
}

class CircularTimerWidget extends StatelessWidget {
  final String label;
  final String value;

  CircularTimerWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
