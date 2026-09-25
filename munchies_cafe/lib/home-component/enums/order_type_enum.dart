import 'package:munchies_cafe/common/extensions.dart';

enum OrderType {
  delivery,
  collection,
}

extension OrderTypeExtension on OrderType {
  String get displayName => _getDisplayName();

  String _getDisplayName() {
    switch (this) {
      default:
        return name.capitalize();
    }
  }
}
