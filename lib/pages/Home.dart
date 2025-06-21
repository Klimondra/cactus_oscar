import 'package:flutter/material.dart';
import "../widgets/reusables/OrangePrimaryButton.dart";
import '../widgets/forHomePage/PermissionButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Kaktus Oskar',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )
        ),
        backgroundColor: Colors.orangeAccent[400],
      ),
      backgroundColor: Colors.orange[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 28,
          children: [
            Image.asset(
                'assets/images/cactus.png',
                width: 250,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 2,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Ahoj, já jsem ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Oskar Suchý',
                        style: TextStyle(
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  )
                ),
                Text(
                  "Neměj strach, o mě se starat nemusíš :)",
                  style: TextStyle(
                    fontSize: 16,

                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                OrangePrimaryButton(
                  label: "Nastavit čas",
                  onPressed: () => Navigator.pushNamed(context, '/timesetup'),
                ),
                NotificationPermissionButton(),
              ],
            )
          ],
        ),
      )
    );
  }
}
