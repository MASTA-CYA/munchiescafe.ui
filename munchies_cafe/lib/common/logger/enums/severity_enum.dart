import 'package:munchies_cafe/common/extensions.dart';

enum Severity {
  information,
  debug,
  warning,
  error,
}

extension SeverityExtension on Severity {
  // `name` is overridden by this extension, so read the enum's own name
  // through dart:core's EnumName extension.
  String get name => EnumName(this).name.toUpperCase();

  String get messageName => EnumName(this).name.capitalize();
}
