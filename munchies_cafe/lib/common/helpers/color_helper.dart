import 'package:flutter/material.dart';

class ColorHelper {
  /// Lighten a color by [percent] amount (100 = white)
  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final double p = percent / 100;
    int channel(double value) => (value * 255.0).round().clamp(0, 255);
    int lightenChannel(double value) {
      final int v = channel(value);
      return v + ((255 - v) * p).round();
    }

    return Color.fromARGB(
      channel(c.a),
      lightenChannel(c.r),
      lightenChannel(c.g),
      lightenChannel(c.b),
    );
  }

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
