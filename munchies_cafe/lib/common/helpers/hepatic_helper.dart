import 'package:flutter/services.dart';
import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';
import 'package:munchies_cafe/common/logger/enums/tag_enum.dart';
import 'package:munchies_cafe/common/logger/logger.dart';
import 'package:munchies_cafe/common/logger/models/log_event_model.dart';

class HepaticHelper {
  static void lightVibration() async {
    HapticFeedback.lightImpact();
    await _logVibrationEventAsync('lightImpact');
  }

  static void mediumVibration() async {
    HapticFeedback.mediumImpact();
    await _logVibrationEventAsync('lightImpact');
  }

  static void strongVibration() async {
    HapticFeedback.heavyImpact();
    await _logVibrationEventAsync('heavyImpact');
  }

  static void tapVibration() async {
    HapticFeedback.selectionClick();
    await _logVibrationEventAsync('selectionClick');
  }

  static void shortVibration() async {
    HapticFeedback.vibrate();
    await _logVibrationEventAsync('shortVibration');
  }

  static Future<void> _logVibrationEventAsync(String type) async {
    await Logger.logAsync(
      LogEvent<HepaticHelper>(
        severity: Severity.information,
        tag: Tag.helper,
        line: 'vibration initiated',
      ),
    );
  }
}
