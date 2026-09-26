import 'package:munchies_cafe/common/extensions.dart';
import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';

enum MessageSeverity {
  critical,
  information,
  warning,
  alert;

  factory MessageSeverity.fromLogEvent(Severity severity) => MessageSeverityExtension.messageSeverityFromLogEvent(severity);
  static MessageSeverity fromJson(String json) => values.byName(json);
  String toJson() => serializableName;
}

extension MessageSeverityExtension on MessageSeverity {
  // `name` is overridden by this extension, so read the enum's own name
  // through dart:core's EnumName extension.
  String get name => EnumName(this).name.capitalize();
  String get serializableName => EnumName(this).name;

  static MessageSeverity messageSeverityFromLogEvent(Severity severity) =>
      switch (severity) {
        Severity.information => MessageSeverity.information,
        Severity.debug => MessageSeverity.alert,
        Severity.warning => MessageSeverity.warning,
        Severity.error => MessageSeverity.critical,
      };
}
