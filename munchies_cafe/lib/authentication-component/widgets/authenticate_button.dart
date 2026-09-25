import 'package:flutter/material.dart';
import 'package:munchies_cafe/common/constants.dart';

class AuthenticateButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onClicked;

  const AuthenticateButtonWidget({
    super.key,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context)
            .elevatedButtonTheme
            .style
            ?.backgroundColor
            ?.resolve(
          {MaterialState.pressed},
        ),
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 8,
        ),
      ),
      onPressed: onClicked,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.merge(
              const TextStyle(
                fontFamily: FontFamily.PRIMARY,
                color: Colors.white,
                // fontSize: 18,
              ),
            ),
      ),
    );
  }
}
