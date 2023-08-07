import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/domain/entities/firebase_messaging_notification.dart';

final firebaseMessagingRepositoryProvider =
Provider<FirebaseMessagingRepository>(
      (ref) => FirebaseMessagingRepositoryImpl(),
);

abstract interface class FirebaseMessagingRepository {
  EitherFailureOr<Unit> init();

  StreamFailureOr<FirebaseMessagingNotification> listenForNotifications();

  StreamFailureOr<String> onTokenRefresh();

  EitherFailureOr<String?> getToken();

  void close();
}

class FirebaseMessagingRepositoryImpl implements FirebaseMessagingRepository {
  StreamController<FirebaseMessagingNotification>?
  _notificationStreamController;
  StreamController<FirebaseMessagingNotification>
  get notificationStreamController {
    _notificationStreamController ??= StreamController();
    return _notificationStreamController!;
  }

  FirebaseMessagingRepositoryImpl();

  @override
  EitherFailureOr<Unit> init() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: {{system_foreground_notifications}},
        badge: false,
        sound: {{system_foreground_notifications}},
      );
    }
    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final message = await FirebaseMessaging.instance.getInitialMessage();
      if (message != null && message.notification != null) {
        _processNotification(message, NotificationStartedType.onLaunch);
      }
      FirebaseMessaging.onMessage.listen((RemoteMessage message) =>
          _processNotification(message, NotificationStartedType.onMessage));
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) =>
          _processNotification(message, NotificationStartedType.onResume));
      return const Right(unit);
    }
    return Left(Failure.permissionDenied());
  }

  @override
  EitherFailureOr<String?> getToken() async =>
      Right(await FirebaseMessaging.instance.getToken());

  @override
  StreamFailureOr<FirebaseMessagingNotification> listenForNotifications() =>
      notificationStreamController.stream.map((event) => Right(event));

  @override
  StreamFailureOr<String> onTokenRefresh() =>
      FirebaseMessaging.instance.onTokenRefresh.map((event) => Right(event));

  @override
  void close() {
    _notificationStreamController?.close();
    _notificationStreamController = null;
  }

  void _processNotification(
      RemoteMessage message,
      NotificationStartedType notificationStartedType,
      ) {
    logDebug('''Got raw notification in ${notificationStartedType.toString()} 
            title: ${message.notification?.title}, 
            body: ${message.notification?.body}, 
            data: ${message.data}''');
    notificationStreamController.add(FirebaseMessagingNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
      notificationStartedType: notificationStartedType,
    ));
  }
}

enum NotificationStartedType { onLaunch, onMessage, onResume }
