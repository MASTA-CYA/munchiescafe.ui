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
  // ignore: unused_field
  static Directory? _eternalDirectory;

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
    // if (UserSettingsService.useEternalStorage ?? true) {
    //   if (_eternalDirectory.isNull) {
    //     final List<Directory>? extDirectories =
    //         await getExternalStorageDirectories();
    //     final List<String> paths = extDirectories
    //             ?.map(
    //               (dir) => dir.path,
    //             )
    //             .toList() ??
    //         [];
    //     final String extPath = paths.firstWhere(
    //       (path) => path.contains(r'/storage/9016-4EF8/'),
    //     );
    //     if (extPath.isNotEmpty) {
    //       _writeToLogFile(
    //         'External storage found at path: $extPath',
    //       );
    //       final List<String> pathSplit = extPath.split('/');
    //       _eternalDirectory =
    //           Directory('/${pathSplit[1]}/${pathSplit[2]}/Eternal');
    //       if (!await _eternalDirectory!.exists()) {
    //         _writeToLogFile(
    //           'Eternal storage directory does not exist. '
    //           'Attempting to create it at path: ${_eternalDirectory!.path}',
    //         );
    //         _eternalDirectory = await _eternalDirectory!.create();
    //       }
    //     } else {
    //       // No SD Card. Use internal storage
    //       Directory? internal = extDirectories?.first;
    //       _eternalDirectory = Directory('${internal!.path}/Eternal');
    //       _writeToLogFile(
    //         'No SD Card found for eternal storage. '
    //         'Using internal storage',
    //       );
    //     }
    //   }
    // }

    String fileName;
    final String basePath;
    switch (T) {
      case Logger:
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

  // static Future<String?> writeImageAsync<T extends CachedAlbumArt>(
  //   T contents,
  // ) async {
  //   String? path;
  //   try {
  //     path = (await (await getFileInstanceAsync<T>(key: contents.key))
  //             .writeAsBytes(
  //       contents.imageBytes,
  //       mode: FileMode.write,
  //       flush: true,
  //     ))
  //         .path;
  //   } on Exception catch (ex) {
  //     path = null;
  //     _writeToLogFile(ex.toString());
  //   }

  //   return path;
  // }

  // static Future<File?> readImageAsync<T>(String key) async {
  //   File? contents;

  //   try {
  //     contents = await getFileInstanceAsync<T>(key: key);
  //   } on Exception catch (ex) {
  //     contents = null;
  //     _writeToLogFile(ex.toString());
  //   }

  //   return contents;
  // }

  static Future<void> removeAsync<T>({String? key}) async {
    try {
      await (await getFileInstanceAsync<T>(key: key)).delete();
    } on Exception catch (ex) {
      _writeToLogFile(ex.toString());
    }
  }

  static Future<bool> fileInstanceExistsAsync<T>({String? key}) async {
    return (await getFileInstanceAsync<T>(key: key)).existsSync();
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
