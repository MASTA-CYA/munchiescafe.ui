import 'package:munchies_cafe/common/constants.dart';
import 'package:munchies_cafe/common/helpers/enums/snackbar_type_enum.dart';
import 'package:flutter/material.dart';

class SnackbarMessageWidget extends StatelessWidget {
  final SnackbarType type;
  final String message;

  const SnackbarMessageWidget({
    super.key,
    required this.type,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageIcon(
          ResizeImage(
            AssetImage(type.icon),
            width: 70,
            height: 70,
            allowUpscaling: false,
          ),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(width: 18),
        Text(
          message,
          style: message.length > 35
              ? Theme.of(context).textTheme.bodySmall?.merge(
                    TextStyle(
                      fontFamily: FontFamily.SECONDARY,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
              : Theme.of(context).textTheme.bodyMedium?.merge(
                    TextStyle(
                      fontFamily: FontFamily.SECONDARY,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
        ),
      ],
    );
  }
}
