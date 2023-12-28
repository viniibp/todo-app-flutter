import 'package:flutter/material.dart';

class Masthead extends StatelessWidget {
  const Masthead({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(5),
        top: Radius.circular(5),
      ),
      child: Image.asset(
        'lib/assets/masthead.png',
      ),
    );
  }
}
