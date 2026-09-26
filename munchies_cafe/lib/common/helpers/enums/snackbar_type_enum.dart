enum SnackbarType {
  information,
  alert,
  warning,
  error,
}

extension SnackbarTypeExtension on SnackbarType {
  String get icon => switch (this) {
        SnackbarType.information => 'assets/images/information.png',
        SnackbarType.alert => 'assets/images/alert.png',
        SnackbarType.warning => 'assets/images/warning.png',
        SnackbarType.error => 'assets/images/error.png',
      };
}
