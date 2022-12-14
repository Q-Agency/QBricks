import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/notifiers/base_state.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/entities/firebase_messaging_notification.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/domain/notifiers/firebase_messaging_notifier.dart';

extension FirebaseMessagingExtensions on WidgetRef {
  void firebaseMessagingNotificationListener(BuildContext _) {
    listen<BaseState<FirebaseMessagingNotification>>(
      firebaseMessagingProvider,
      (previous, current) {
        current.maybeWhen(
          data: (firebaseMessagingNotification) {
            log('to show $firebaseMessagingNotification');
          },
          orElse: () => null,
        );
      },
    );
  }
}
