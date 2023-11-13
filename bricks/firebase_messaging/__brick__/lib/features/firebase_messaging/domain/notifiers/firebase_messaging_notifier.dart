import 'package:flutter/foundation.dart';
{{#system_foreground_notifications}}
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
{{/system_foreground_notifications}}
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/base_state_notifier.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/repositories/firebase_messaging_repository.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/domain/entities/firebase_messaging_notification.dart';

final firebaseMessagingNotifierProvider = StateNotifierProvider.autoDispose<
    FirebaseMessagingNotifier, BaseState<FirebaseMessagingNotification>>(
  (ref) => FirebaseMessagingNotifier(
    ref.watch(firebaseMessagingRepositoryProvider),
    ref,
  )..init(),
);

class FirebaseMessagingNotifier
    extends BaseStateNotifier<FirebaseMessagingNotification> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;
  {{#system_foreground_notifications}}
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  {{/system_foreground_notifications}}

  FirebaseMessagingNotifier(this._firebaseMessagingRepository, super.ref);

  @override
  void dispose() {
    _firebaseMessagingRepository.close();
    super.dispose();
  }

  Future<void> init() async {
    if (kIsWeb) return;

    final result = await _firebaseMessagingRepository.init();
    result.fold((failure) => setGlobalFailure(failure), (_) {
      _getToken();
      _onTokenRefresh();
      _listenForNotification();
      {{#system_foreground_notifications}}
      _initializeFlutterLocalNotificationsPlugin();
      {{/system_foreground_notifications}}
    });
  }

  // ignore: avoid-redundant-async
  Future<void> _listenForNotification() async {
    await for (final result
        in _firebaseMessagingRepository.listenForNotifications()) {
      result.fold(
        setGlobalFailure,
        (notification) {
          {{#system_foreground_notifications}}
          if (notification.notificationStartedType ==
              NotificationStartedType.onMessage) {
            return _showLocalNotification(notification);
          }
          {{/system_foreground_notifications}}
          state = BaseState.data(notification);
        },
      );
    }
  }

  Future<void> _getToken() async {
    final result = await _firebaseMessagingRepository.getToken();
    result.fold((_) => null, (token) {
      logDebug('notification token: $token');
    });
  }

  // ignore: avoid-redundant-async
  Future<void> _onTokenRefresh() async {
    await for (final result in _firebaseMessagingRepository.onTokenRefresh()) {
      result.fold(
        (_) => null,
        (token) {
          logDebug('notification token changed: $token');
        },
      );
    }
  }

  {{#system_foreground_notifications}}
  Future<void> _initializeFlutterLocalNotificationsPlugin() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettingsAndroid = AndroidInitializationSettings(
        '@drawable/your_notification_icon', // take a look at README.md push notification icon part
      );
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await _flutterLocalNotificationsPlugin?.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) =>
            _parseLocalNotificationPayload(
          notificationResponse: details,
          notificationStartedType: NotificationStartedType.onResume,
        ),
      );
      final notificationAppLaunchDetails =
          await _flutterLocalNotificationsPlugin
              ?.getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.notificationResponse != null) {
        _parseLocalNotificationPayload(
          notificationResponse:
              notificationAppLaunchDetails!.notificationResponse!,
          notificationStartedType: NotificationStartedType.onLaunch,
        );
      }
    }
  }

  void _showLocalNotification(FirebaseMessagingNotification notification) {
    if (_flutterLocalNotificationsPlugin == null) return;
    final title = notification.title;
    final body = notification.body;
    if (title == null && body == null) {
      return;
    }
    _flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      title,
      body,
      _androidNotificationDetails(),
      payload: jsonEncode(notification.toJson()),
    );
  }

  void _parseLocalNotificationPayload({
    required NotificationResponse notificationResponse,
    required NotificationStartedType notificationStartedType,
  }) {
    try {
      final payloadJson = jsonDecode(notificationResponse.payload!);
      final notification = FirebaseMessagingNotification.fromJson(payloadJson);
      state = BaseState.data(notification.copyWith(
        notificationStartedType: notificationStartedType,
      ));
    } catch (e) {
      logDebug('_parseLocalNotificationPayload error: $e');
    }
  }

  NotificationDetails _androidNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
  {{/system_foreground_notifications}}
}
