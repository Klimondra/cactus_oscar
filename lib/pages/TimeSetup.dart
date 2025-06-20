import "package:flutter/material.dart";
import "/widgets/reusables/OrangePrimaryButton.dart";
import "package:hive_flutter/hive_flutter.dart";
import "../scripts/notification_service.dart";

class Timesetup extends StatelessWidget {
  const Timesetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nastavit čas',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orangeAccent[400],
      ),
      backgroundColor: Colors.orange[300],
      body: const Center(
        child: ContentOfSetup(),
      ),
    );
  }
}

class ContentOfSetup extends StatefulWidget {
  const ContentOfSetup({super.key});

  @override
  State<ContentOfSetup> createState() => _ContentOfSetupState();
}

class _ContentOfSetupState extends State<ContentOfSetup> {
  TimeOfDay selectedTime = TimeOfDay.now();
  late final Box settingsBox;

  void _getData() async {
    settingsBox = await Hive.openBox("settingsDb");

    int hourOfTime = settingsBox.get("hour", defaultValue: selectedTime.hour);
    int minuteOfTime = settingsBox.get("minute", defaultValue: selectedTime.minute);

    setState(() {
      selectedTime = TimeOfDay(hour: hourOfTime, minute: minuteOfTime);
    });
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: "Vyber čas oznámení",
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });

      await settingsBox.put("hour", picked.hour);
      await settingsBox.put("minute", picked.minute);
      await scheduleNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 42,
      children: [
        Column(
          children: [
            const Text(
              "Oznámení obdržíš v",
              style: TextStyle(fontSize: 21),
            ),
            Text(
              "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(
                fontSize: 60,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          spacing: 16,
          children: [
            OrangePrimaryButton(
              label: "Změnit čas",
              onPressed: _selectTime,
            ),
            OrangePrimaryButton(
              label: "Vyzkoušet oznámení",
              onPressed: () {
                showTestNotification();
              },
            ),
          ],
        ),
      ],
    );
  }
}
