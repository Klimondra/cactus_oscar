import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import "../reusables/OrangePrimaryButton.dart";

class NotificationPermissionButton extends StatefulWidget {
  const NotificationPermissionButton({super.key});

  @override
  State<NotificationPermissionButton> createState() => _NotificationPermissionButtonState();
}

class _NotificationPermissionButtonState extends State<NotificationPermissionButton> {
  bool _isPermissionGranted = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.notification.status;
    setState(() {
      _isPermissionGranted = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    final result = await Permission.notification.request();
    if (result.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isPermissionGranted
        ? OrangePrimaryButton(
      onPressed: _requestPermission,
      label: "Povolit oznámení",
    )
        : const SizedBox.shrink(); // Nic nezobrazí
  }
}
