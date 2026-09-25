enum NotificationType {
  message,
  favorite,
}

extension NotificationTypeExtension on NotificationType {
  String get icon => _getNotificationIcon();

  String _getNotificationIcon() {
    switch (this) {
      case NotificationType.favorite:
        return 'assets/images/favorite.png';
      case NotificationType.message:
      default:
        return 'assets/images/message.png';
    }
  }
}
