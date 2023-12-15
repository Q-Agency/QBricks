import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsHandlerRepositoryProvider = Provider(
  (_) => PermissionsHandlerRepositoryImpl(),
);

abstract interface class PermissionsHandlerRepository {
  Future requestPermission({
    required Function() onSuccess,
    required Function() onFail,
    required Permission permission,
  });
}

class PermissionsHandlerRepositoryImpl implements PermissionsHandlerRepository {
  PermissionsHandlerRepositoryImpl();

  @override
  Future requestPermission({
    required Function() onSuccess,
    required Function() onFail,
    required Permission permission,
  }) async {
    final status = await permission.request();
    if (status.isGranted) {
      return onSuccess();
    } else {
      return onFail();
    }
  }
}
