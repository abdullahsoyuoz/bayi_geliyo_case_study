import 'package:flutter/material.dart';

class StopwatchHandler {
  final Stopwatch _stopwatch = Stopwatch();
  static final StopwatchHandler _instance = StopwatchHandler._internal();

  factory StopwatchHandler() {
    return _instance;
  }

  StopwatchHandler._internal();

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
  }

  void stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      debugPrint('stopwatch: ${_stopwatch.elapsedMilliseconds / 1000}');
    }
  }

  void reset() {
    _stopwatch.reset();
  }

  double getElapsedTimeInSeconds() {
    return _stopwatch.elapsedMilliseconds / 1000;
  }
}
