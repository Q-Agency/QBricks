import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/repositories/firebase_messaging_repository.dart';

part 'firebase_messaging_notification.g.dart';

@JsonSerializable()
class FirebaseMessagingNotification extends Equatable {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final NotificationStartedType notificationStartedType;

  const FirebaseMessagingNotification({
    this.title,
    this.body,
    this.data,
    this.notificationStartedType = NotificationStartedType.onResume,
  });

  factory FirebaseMessagingNotification.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessagingNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessagingNotificationToJson(this);

  FirebaseMessagingNotification copyWith({
    String? title,
    String? body,
    Map<String, dynamic>? data,
    NotificationStartedType? notificationStartedType,
  }) {
    return FirebaseMessagingNotification(
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      notificationStartedType:
          notificationStartedType ?? this.notificationStartedType,
    );
  }

  @override
  List<Object?> get props => [
        title,
        body,
        data,
        notificationStartedType,
      ];
}
