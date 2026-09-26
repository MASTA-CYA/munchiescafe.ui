import 'package:munchies_cafe/common/helpers/enums/snackbar_duration_enum.dart';
import 'package:munchies_cafe/common/helpers/enums/snackbar_type_enum.dart';
import 'package:munchies_cafe/common/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static Future<void> showMessage(
    BuildContext context,
    SnackbarType type,
    String message, {
    SnackbarDuration? duration,
    SnackBarAction? action,
  }) async{
    if (!context.mounted || message.isEmpty) {
      return;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration?.duration ?? const Duration(milliseconds: 4000),
        content: SnackbarMessageWidget(type: type, message: message),
        action: action,
      ),
    );
  }
}
