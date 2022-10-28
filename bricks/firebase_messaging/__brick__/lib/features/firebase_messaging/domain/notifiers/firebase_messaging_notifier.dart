import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/notifiers/base_state.dart';
import 'package:{{project_name.snakeCase()}}/common/domain/notifiers/base_state_notifier.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/entities/firebase_messaging_notification.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/repositories/firebase_messaging_repository.dart';

final firebaseMessagingProvider = StateNotifierProvider<
    FirebaseMessagingNotifier, BaseState<FirebaseMessagingNotification>>(
  (ref) => FirebaseMessagingNotifier(
    ref.watch(firebaseMessagingRepositoryProvider),
    ref,
  ),
);

class FirebaseMessagingNotifier
    extends BaseStateNotifier<FirebaseMessagingNotification> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;

  FirebaseMessagingNotifier(this._firebaseMessagingRepository, super.reader) {
    _init();
  }

  @override
  void dispose() {
    _firebaseMessagingRepository.close();
    super.dispose();
  }

  Future<void> _init() async {
    final result = await _firebaseMessagingRepository.init();
    result.fold((failure) => setGlobalFailure(failure), (_) {
      _getToken();
      _onTokenRefresh();
      _listenForNotification();
    });
  }

  void _listenForNotification() async {
    await for (FirebaseMessagingNotification firebaseMessagingNotification
        in _firebaseMessagingRepository.listenForNotifications()) {
      state = BaseState.data(firebaseMessagingNotification);
    }
  }

  void _getToken() async {
    final result = await _firebaseMessagingRepository.getToken();
    result.fold((_) => null, (token) => log('notification token: $token'));
  }

  void _onTokenRefresh() async {
    await for (String token in _firebaseMessagingRepository.onTokenRefresh()) {
      log('notification token changed: $token');
    }
  }
}
