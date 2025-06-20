import 'package:flutter/material.dart';

class OrangePrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const OrangePrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orangeAccent[400]!,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              colors: [
                Colors.orange[400]!,
                Colors.orange[500]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
