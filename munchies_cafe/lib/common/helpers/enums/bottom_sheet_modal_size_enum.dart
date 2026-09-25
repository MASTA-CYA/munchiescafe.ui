enum BottomSheetModalSize {
  full,
  threeQuarter,
  half,
  quarter,
}

extension BottomSheetModalSizeExtension on BottomSheetModalSize {
  double get height => _getModalHeight();

  double _getModalHeight() {
    switch (this) {
      case BottomSheetModalSize.full:
        return 1.14;
      case BottomSheetModalSize.threeQuarter:
        return 1.4;
      case BottomSheetModalSize.half:
        return 2;
      case BottomSheetModalSize.quarter:
        return 4;
      default:
        return 2;
    }
  }
}
