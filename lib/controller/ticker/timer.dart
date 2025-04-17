// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:ui';

/// A class to handle timer operations, can be used as countdown or countup timer.
class TimerHandler {
  late StreamController<int> controller;
  Timer? _timer;
  int? _counter;
  final int _initialCount;
  final bool _isCountdown;
  late final Stream<int> _stream; // Initialize _stream when declaring
  VoidCallback? _onCompleteCallback;
  void Function(int)? _perSecondCallback;

  /// Constructor for creating an instance of TimerHandler.
  TimerHandler(this._isCountdown, this._initialCount, this._onCompleteCallback, this._perSecondCallback) {
    _counter = _initialCount;
    controller = StreamController<int>.broadcast();
    _stream = controller.stream; // Removed the late keyword and initialized here
    controller.add(_counter!);
  }

  /// Method to create a countdown timer.
  static TimerHandler counttimer({
    required int count,
    VoidCallback? onCountdownComplete,
  }) {
    return TimerHandler(true, count, onCountdownComplete, null);
  }

  /// Method to create a countup timer.
  static TimerHandler timer({
    int initialCount = 0,
    required void Function(int) callbackPerSecond,
  }) {
    return TimerHandler(false, initialCount, null, callbackPerSecond);
  }

  Stream<int> get stream => _stream;

  int get getCount => _counter ?? 0;

  bool get isRunning => _timer?.isActive ?? false;

  /// Starts the timer.
  void start() {
    if (_timer != null && _timer!.isActive) {
      throw Exception("Timer is already running.");
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_isCountdown) {
        if (_counter! > 0) {
          _counter = _counter! - 1;
          controller.add(_counter!);
          if (_counter == 0 && _onCompleteCallback != null) {
            _onCompleteCallback!();
          }
        }
      } else {
        _counter = _counter! + 1;
        controller.add(_counter!);
        if (_perSecondCallback != null) {
          _perSecondCallback!(_counter!);
        }
      }
    });
  }

  /// Pauses the timer.
  void pause() {
    if (_timer == null || !_timer!.isActive) {
      throw Exception("Timer is not running.");
    }
    _timer!.cancel();
  }

  /// Resets the timer.
  void reset() {
    _counter = _initialCount;
    controller.add(_counter!);
  }

  /// Disposes resources used by the timer.
  void dispose() {
    _timer?.cancel();
    controller.close();
  }
}
