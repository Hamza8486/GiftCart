import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:giftcart/util/translation_keys.dart';



class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
      setState(() {
        _elapsedTime = _stopwatch.elapsed;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _stopwatch.stop();
    setState(() {
      _elapsedTime = _stopwatch.elapsed;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _stopwatch.reset();
    setState(() {
      _elapsedTime = Duration.zero;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stopwatchTimer.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_formatDuration(_elapsedTime)}',
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _stopTimer : _startTimer,
                  child: Text(_stopwatch.isRunning ? stop.tr : start.tr),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text(stop.tr),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text(reset.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitMilliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds.$twoDigitMilliseconds";
  }
}
