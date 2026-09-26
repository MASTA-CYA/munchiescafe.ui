enum NotificationType {
  message,
  favorite,
}

extension NotificationTypeExtension on NotificationType {
  String get icon => switch (this) {
        NotificationType.favorite => 'assets/images/favorite.png',
        NotificationType.message => 'assets/images/message.png',
      };
}
