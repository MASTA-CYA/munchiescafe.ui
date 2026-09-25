import 'package:flutter/material.dart';

class NumberedParagraphWidget extends StatelessWidget {
  final String paragraph;

  const NumberedParagraphWidget({
    super.key,
    required this.paragraph,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> points = _getBulletPoints();
    return Column(
      children: points
          .map(
            (point) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${points.indexOf(point) + 1}. '),
                Expanded(
                  child: Text(point),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  List<String> _getBulletPoints() {
    return paragraph.split('\n');
  }
}
