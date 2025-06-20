import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> autoTimeSelector() async {
  final settingsBox = await Hive.box("settingsDb");

  int? hourOfTime = settingsBox.get("hour");
  int? minuteOfTime = settingsBox.get("minute");

  if (hourOfTime == null || minuteOfTime == null) {
    hourOfTime = TimeOfDay.now().hour;
    minuteOfTime = TimeOfDay.now().minute;

    await settingsBox.put("hour", hourOfTime);
    await settingsBox.put("minute", minuteOfTime);
  }
}