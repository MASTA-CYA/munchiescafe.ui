import 'package:flutter/material.dart';

class PageBackgroundWidget extends StatelessWidget {
  final Widget child;

  const PageBackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                const AssetImage('assets/images/background.jpg'),
                width: MediaQuery.of(context).size.width.toInt(),
                allowUpscaling: true,
              ),
              fit: BoxFit.fitWidth,
              opacity: 0.04,
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
