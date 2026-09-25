import 'dart:io';

import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';
import 'package:munchies_cafe/common/logger/enums/tag_enum.dart';
import 'package:munchies_cafe/common/logger/models/log_event_model.dart';
import 'package:munchies_cafe/common/services/file_storage_service.dart';
import 'package:munchies_cafe/message-component/models/message_severity_enum.dart';
import 'package:munchies_cafe/message-component/services/message_service.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static Future logAsync(
    LogEvent event, {
    bool shouldSaveMessage = false,
  }) async {
    if (!kReleaseMode) debugPrint(event.toString());

    await FileStorageService.writeStringAsync<Logger>(event.toString());

    if (shouldSaveMessage) {
      await MessageService().saveMessageAsync(
        '${event.severity.messageName} event on ${event.caller}',
        event.line,
        MessageSeverity.fromLogEvent(event.severity),
      );
    }
  }

  static Future<File> getLogFileAsync<T>() async {
    await logAsync(
      LogEvent<Logger>(
        severity: Severity.information,
        tag: Tag.service,
        line: '$T requested the application log file',
      ),
    );

    return await FileStorageService.getFileInstanceAsync<Logger>();
  }
}
