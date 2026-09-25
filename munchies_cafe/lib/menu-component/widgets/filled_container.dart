import 'package:flutter/material.dart';

class FilledContainerWidget extends StatelessWidget {
  final Widget child;
  final int percent;

  const FilledContainerWidget({
    super.key,
    required this.child,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    Color firstColor = Theme.of(context).colorScheme.secondary;
    Color secondColor = Theme.of(context).colorScheme.onPrimary;

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [
            0,
            percent / 100,
            percent / 100,
          ],
          colors: [
            firstColor,
            firstColor,
            secondColor,
          ],
        ).createShader(rect);
      },
      child: child,
    );
  }
}
