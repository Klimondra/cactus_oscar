import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:timezone/timezone.dart" as tz;
import "package:timezone/data/latest.dart" as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const WindowsInitializationSettings initializationSettingsWindows =
  WindowsInitializationSettings(
      appName: 'Kaktus Oskar', appUserModelId: 'Klimondra.Cactus_Oscar', guid: 'fdcfcc86-12b2-403e-98dd-ee659792c9fa');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    windows: initializationSettingsWindows,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print('Kliknuto na notifikaci: ${response.payload}');
    },
  );
}

Future<void> showTestNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    "important_channel",
    "Testovací notifikace",
    channelDescription: "Testovací aplikace vyvolaná tlačítkem v aplikaci",
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    icon: '@mipmap/ic_launcher',
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    '🎉 Notifikace fungují! 🔔',
    'Hurá, všechno funguje správně.',
    notificationDetails,
  );
}


void initializeTimeZones() {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Prague'));
}

Future<void> scheduleNotification() async {
  await flutterLocalNotificationsPlugin.cancelAll();

  final settingsBox = await Hive.box("settingsDb");
  int hourOfTime = settingsBox.get("hour", defaultValue: TimeOfDay.now().hour);
  int minuteOfTime = settingsBox.get("minute", defaultValue: TimeOfDay.now().minute);

  var now = tz.TZDateTime.now(tz.local);
  var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hourOfTime, minuteOfTime);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }

  const androidDetails = AndroidNotificationDetails(
    'daily_channel_id',
    'Denní upozornění',
    channelDescription: 'Notifikace, která ti připomene, že Oskar nepotřebuje zalévat.',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    icon: '@mipmap/ic_launcher',
  );

  const notificationDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    1,
    '🌵 Nezapomeň na Oskara!',
    'Nezapomeň, že ani dnes není potřeba zalévat Oskara! Užívej si den! 😊',
    scheduledDate,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

/* ***** DEBUG *****
Future<void> scheduleTestNotification() async {
  try {
    final location = tz.getLocation('Europe/Prague');
    var now = tz.TZDateTime.now(location);
    var testDate = now.add(const Duration(minutes: 1)); // Za 1 minutu

    const androidDetails = AndroidNotificationDetails(
      'test_channel_id',
      'Test notifikace',
      channelDescription: 'Testovací naplánovaná notifikace',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      999,
      'Test naplánované notifikace',
      'Tato notifikace byla naplánována na za 1 minutu',
      testDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    print("Test notifikace naplánována na: $testDate");
  } catch (e) {
    print("Chyba při plánování test notifikace: $e");
  }
}
*/
