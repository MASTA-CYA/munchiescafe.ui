enum SnackbarDuration {
  short,
  long,
  infinite,
}

extension SnackbarDurationExtension on SnackbarDuration {
  Duration get duration => switch (this) {
        SnackbarDuration.short => const Duration(seconds: 2),
        SnackbarDuration.long => const Duration(seconds: 8),
        SnackbarDuration.infinite => const Duration(days: 365),
      };
}
