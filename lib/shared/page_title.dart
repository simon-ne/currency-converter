import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;
  const PageTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
