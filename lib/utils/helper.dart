import 'package:flutter/material.dart';

class Helper {
  static void displaySnackMessage(
    BuildContext context,
    Color backgroundColor,
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.only(
          bottom: 18,
          top: 12,
          left: 24,
        ),
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}