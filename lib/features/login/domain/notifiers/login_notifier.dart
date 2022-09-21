import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:myapp/features/login/data/repositories/login_repository.dart';

import 'package:myapp/common/domain/notifiers/base_state_notifier.dart';
import 'package:myapp/common/domain/notifiers/base_state.dart';

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, BaseState<User, Object>>((ref) {
  return LoginNotifier(
    ref.read(loginRepositoryProvider),
    ref.read,
  );
});

class LoginNotifier extends BaseStateNotifier<User, Object> {
  final LoginRepository _loginRepository;

  LoginNotifier(this._loginRepository, Reader reader)
      : super(const BaseState.loading(), reader);

  Future<void> login() async {
    throw UnimplementedError();
  }

  Future<void> logout() async {
    throw UnimplementedError();
  }
}
