import 'package:munchies_cafe/common/notifications/enums/notification_type_enum.dart';
import 'package:munchies_cafe/message-component/models/message_severity_enum.dart';

class AppNotification {
  final String title;
  final String message;
  final String notificationText;
  final MessageSeverity severity;
  final NotificationType? type;

  AppNotification({
    required this.title,
    required this.message,
    required this.notificationText,
    required this.severity,
    this.type,
  });
}
