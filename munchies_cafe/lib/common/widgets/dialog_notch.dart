import 'package:flutter/material.dart';

class DialogNotchWidget extends StatelessWidget {
  const DialogNotchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        width: 100,
        height: 5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
