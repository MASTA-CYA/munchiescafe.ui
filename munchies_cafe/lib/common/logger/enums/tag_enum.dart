import 'package:munchies_cafe/common/extensions.dart';

enum Tag {
  application,
  http,
  service,
  widget,
  extension,
  observer,
  helper,
  strategy,
  handler,
}

extension TagExtension on Tag {
  String get name {
    switch (this) {
      case Tag.application:
      case Tag.http:
      case Tag.service:
      case Tag.widget:
      case Tag.extension:
      case Tag.observer:
      case Tag.helper:
      case Tag.strategy:
        return EnumName(this).name.toUpperCase();
      default:
        return "UNKNOWN";
    }
  }

  String get messageName {
    switch (this) {
      case Tag.application:
      case Tag.http:
      case Tag.service:
      case Tag.widget:
      case Tag.extension:
      case Tag.observer:
      case Tag.helper:
      case Tag.handler:
        return EnumName(this).name.capitalize();
      default:
        return "Unknown";
    }
  }
}
