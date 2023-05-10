import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/data/repositories/firebase_messaging_repository.dart';
import 'package:{{project_name.snakeCase()}}/features/firebase_messaging/domain/entities/firebase_messaging_notification.dart';

final firebaseMessagingProvider = BaseStateNotifierProvider<
    FirebaseMessagingNotifier, FirebaseMessagingNotification>(
  (ref) => FirebaseMessagingNotifier(
    ref.watch(firebaseMessagingRepositoryProvider),
    ref,
  )..init(),
);

class FirebaseMessagingNotifier
    extends BaseStateNotifier<FirebaseMessagingNotification> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;

  FirebaseMessagingNotifier(this._firebaseMessagingRepository, super.ref);

  @override
  void dispose() {
    _firebaseMessagingRepository.close();
    super.dispose();
  }

  Future<void> init() async {
    final result = await _firebaseMessagingRepository.init();
    result.fold((failure) => setGlobalFailure(failure), (_) {
      _getToken();
      _onTokenRefresh();
      _listenForNotification();
    });
  }

  void _listenForNotification() async {
    await for (final result
        in _firebaseMessagingRepository.listenForNotifications()) {
      result.fold(setGlobalFailure, (r) => state = BaseState.data(r));
    }
  }

  void _getToken() async {
    final result = await _firebaseMessagingRepository.getToken();
    result.fold((_) => null, (token) => logDebug('notification token: $token'));
  }

  void _onTokenRefresh() async {
    await for (final result in _firebaseMessagingRepository.onTokenRefresh()) {
      result.fold(
        (_) => null,
        (token) => logDebug('notification token changed: $token'),
      );
    }
  }
}
