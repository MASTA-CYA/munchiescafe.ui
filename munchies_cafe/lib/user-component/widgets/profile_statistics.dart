import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileStatisticsWidget extends StatelessWidget {
  const ProfileStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context, '2', 'Orders'),
        buildDivider(),
        buildButton(
          context,
          NumberFormat.simpleCurrency(locale: 'en_za').format(541),
          'Wallet',
        ),
        buildDivider(),
        buildButton(context, '5', 'Reviews'),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 30,
      child: const VerticalDivider(),
    );
  }

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
