import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';

class NoFilterOptionsWidget extends StatelessWidget {
  const NoFilterOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 150,
          child: const Icon(
            Icons.filter_alt_off,
            size: 150,
          ),
        ),
        Text(
          'NO OPTIONS AVAILABLE',
          style: Theme.of(context).textTheme.titleLarge?.merge(
                const TextStyle(fontFamily: FontFamily.PRIMARY),
              ),
        ),
      ],
    );
  }
}
