import 'dart:convert';
import 'dart:io';

import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';
import 'package:munchies_cafe/common/logger/enums/tag_enum.dart';
import 'package:munchies_cafe/common/logger/logger.dart';
import 'package:munchies_cafe/common/logger/models/log_event_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  static Directory? _appDocsDirectory;
  static Directory? _appSupDirectory;
  static Directory? _appTempDirectory;

  static Future<File> getFileInstanceAsync<T>({String? key}) async {
    if (_appDocsDirectory.isNull) {
      _appDocsDirectory = await getApplicationDocumentsDirectory();
    }
    if (_appSupDirectory.isNull) {
      _appSupDirectory = await getApplicationSupportDirectory();
    }
    if (_appTempDirectory.isNull) {
      _appTempDirectory = await getApplicationCacheDirectory();
    }

    String fileName;
    final String basePath;
    switch (T) {
      case const (Logger):
        basePath = _appSupDirectory!.path;
        fileName = 'logs.log';
        break;
      default:
        basePath = _appTempDirectory!.path;
        fileName = '${key ?? T}.json';
        break;
    }

    return File('$basePath/$fileName');
  }

  static Future<void> writeStringAsync<T>(
    String contents, {
    Encoding encoding = utf8,
    FileMode mode = FileMode.writeOnlyAppend,
    String? key,
  }) async {
    try {
      (await getFileInstanceAsync<T>(key: key)).writeAsStringSync(
        contents,
        encoding: encoding,
        mode: mode,
        flush: true,
      );
    } on Exception catch (ex) {
      _writeToLogFile(ex.toString());
    }
  }

  static Future<String?> readAsync<T>({String? key}) async {
    String? contents;

    try {
      contents = await (await getFileInstanceAsync<T>(key: key)).readAsString();
    } on Exception catch (ex) {
      _writeToLogFile(ex.toString());
    }

    return contents;
  }

  static Future<void> removeAsync<T>({String? key}) async {
    try {
      await (await getFileInstanceAsync<T>(key: key)).delete();
    } on Exception catch (ex) {
      _writeToLogFile(ex.toString());
    }
  }

  static void _writeToLogFile(String line) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        Logger.logAsync(
          LogEvent<FileStorageService>(
            severity: Severity.information,
            tag: Tag.service,
            line: line,
          ),
        );
      },
    );
  }
}
