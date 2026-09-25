import 'package:munchies_cafe/common/logger/enums/severity_enum.dart';
import 'package:munchies_cafe/common/logger/enums/tag_enum.dart';

class LogEvent<T> {
  final String time = DateTime.now().toIso8601String();
  final Severity severity;
  final Tag tag;
  final String line;

  LogEvent({
    required this.severity,
    required this.tag,
    required this.line,
  });

  String get caller => '$T';

  @override
  String toString() {
    return '\n$time [$T] [${tag.name}] [${severity.name}] $line';
  }
}
