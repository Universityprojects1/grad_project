import 'package:flutter/material.dart';
import 'custom_timer.dart';

class TimerManager {
  static final TimerManager _instance = TimerManager._internal();

  factory TimerManager() => _instance;

  TimerManager._internal();

  final Map<String, CustomTimer> _timers = {};

  CustomTimer getTimer(String key) {
    if (!_timers.containsKey(key)) {
      _timers[key] = CustomTimer(
        count: 0,
        counter: 0,
        countdownSeconds: 0,
        dateController: TextEditingController(),
        startTimeController: TextEditingController(),
      );
    }
    return _timers[key]!;
  }
}
