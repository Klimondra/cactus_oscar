import 'package:flutter/material.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'pages/Home.dart';
import "pages/TimeSetup.dart";
import "scripts/auto_time_selector.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("settingsDb");
  await autoTimeSelector();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/timesetup": (context) => const Timesetup(),
      },
    );
  }
}