import 'dart:ui';

enum TransitionDirection {
  /// Right to Left
  rtl,

  /// Left to Right
  ltr,

  /// Top to Bottom
  ttb,

  /// Bottom to Top
  btt;

  factory TransitionDirection.fromName(String name) =>
      TransitionDirectionExtension.getTransitionDirectionFromName(name);
}

extension TransitionDirectionExtension on TransitionDirection {
  Offset get offset => switch (this) {
        TransitionDirection.ltr => const Offset(1.0, 0.0),
        TransitionDirection.rtl => const Offset(-1.0, 0.0),
        TransitionDirection.ttb => const Offset(0.0, -1.0),
        TransitionDirection.btt => const Offset(0.0, 1.0),
      };

  static TransitionDirection getTransitionDirectionFromName(String name) {
    TransitionDirection direction;

    switch (name) {
      case 'ltr':
        direction = TransitionDirection.ltr;
        break;
      case 'rtl':
        direction = TransitionDirection.rtl;
        break;
      case 'ttb':
        direction = TransitionDirection.ttb;
        break;
      case 'btt':
        direction = TransitionDirection.btt;
        break;
      default:
        direction = TransitionDirection.ltr;
        break;
    }

    return direction;
  }
}
