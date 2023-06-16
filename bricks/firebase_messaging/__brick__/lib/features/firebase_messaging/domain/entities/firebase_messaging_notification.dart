import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/repositories/firebase_messaging_repository.dart';

part 'firebase_messaging_notification.g.dart';

@JsonSerializable()
class FirebaseMessagingNotification extends Equatable {
  @_RemoteMessageConverter()
  final RemoteMessage remoteMessage;
  final NotificationStartedType notificationStartedType;

  const FirebaseMessagingNotification({
    required this.remoteMessage,
    required this.notificationStartedType,
  });

  factory FirebaseMessagingNotification.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessagingNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessagingNotificationToJson(this);

  FirebaseMessagingNotification copyWith({
    RemoteMessage? remoteMessage,
    NotificationStartedType? notificationStartedType,
  }) {
    return FirebaseMessagingNotification(
      remoteMessage: remoteMessage ?? this.remoteMessage,
      notificationStartedType:
          notificationStartedType ?? this.notificationStartedType,
    );
  }

  @override
  List<Object?> get props => [remoteMessage, notificationStartedType];
}

class _RemoteMessageConverter
    extends JsonConverter<RemoteMessage, Map<String, dynamic>> {
  const _RemoteMessageConverter();

  @override
  RemoteMessage fromJson(json) {
    return RemoteMessage.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(object) {
    return object.toMap();
  }
}
