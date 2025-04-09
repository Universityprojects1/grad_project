import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../timer.dart';

class CustomTimer {
  void Function()? onUpdate;

  CustomTimer({
    required this.count,
    required this.counter,
    required this.countdownSeconds,
    this.onUpdate,
    required this.dateController,
    required this.startTimeController,
  });

  int counter;
  int count;
  TextEditingController dateController;

  TextEditingController startTimeController;

  int countdownSeconds;
  late CountdownTimer countdownTimer1;
  late CountdownTimer countdownTimer2;
  bool isTimerRunning = false;

  void calculateTimeDifference() {
    DateTime? targetDateTime = DateFormat('dd-MM-yyyy hh:mm a')
        .parse('${dateController.text} ${startTimeController.text}');

    DateTime now = DateTime.now();

    if (targetDateTime.isBefore(now)) {
      targetDateTime = targetDateTime.add(const Duration(days: 1));
    }
    Duration difference = targetDateTime.difference(now);
    countdownSeconds = difference.inSeconds;
    initTimerOperation(countdownSeconds);
  }

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  int convertHoursToSeconds(int hours) {
    return hours * 3600;
  }

  void initTimerOperation(int second) {
    countdownTimer1 = CountdownTimer(
      seconds: second,
      onTick: (seconds) {
        isTimerRunning = true;
        if (seconds == 0) {
          initTimerOperationForCounter(convertHoursToSeconds(counter));
        }
      },
      onFinished: () {
        isTimerRunning = false;
        countdownTimer1.stop();
      },
    );

    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          countdownTimer1.pause(second);
        }
      }

      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          countdownTimer1.resume();
        }
      }
      return Future(() => null);
    });

    isTimerRunning = true;
    countdownTimer1.start();
  }

  void initTimerOperationForCounter(int second) {
    countdownTimer2 = CountdownTimer(
      seconds: second,
      onTick: (seconds) {
        isTimerRunning = true;
        count = seconds;
        onUpdate?.call();
      },
      onFinished: () {
        isTimerRunning = false;
        countdownTimer2.stop();
      },
    );

    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg == AppLifecycleState.paused.toString()) {
        if (isTimerRunning) {
          countdownTimer2.pause(second);
        }
      }

      if (msg == AppLifecycleState.resumed.toString()) {
        if (isTimerRunning) {
          countdownTimer2.resume();
        }
      }
      return Future(() => null);
    });

    isTimerRunning = true;
    countdownTimer2.start();
  }

  void stopTimer() {
    isTimerRunning = false;
    countdownTimer2.stop();
  }

  void resetTimer() {
    stopTimer();
    counter = 0;
    onUpdate?.call();
  }
}
