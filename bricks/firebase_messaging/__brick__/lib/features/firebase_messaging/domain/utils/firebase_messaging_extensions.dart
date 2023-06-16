import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/entities/firebase_messaging_notification.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/domain/notifiers/firebase_messaging_notifier.dart';

extension FirebaseMessagingExtensions on WidgetRef {
  void firebaseMessagingNotificationListener(BuildContext _) {
    listen<BaseState<FirebaseMessagingNotification>>(
      firebaseMessagingNotifierProvider,
      (previous, current) {
        current.maybeWhen(
          data: (firebaseMessagingNotification) {
            logDebug('to show $firebaseMessagingNotification');
          },
          orElse: () => null,
        );
      },
    );
  }
}
