import 'package:{{project_name.snakeCase()}}/common/data/generic_error_resolver.dart';
import 'package:{{project_name.snakeCase()}}/common/data/services/permissions_handler_service.dart';
import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final permissionHandlerRepositoryProvider =
    Provider<PermissionsHandlerRepository>(
  (ref) => PermissionsHandlerRepositoryImpl(
    ref.watch(permissionsHandlerServiceProvider),
  ),
);

abstract interface class PermissionsHandlerRepository {
  EitherFailureOr<bool> hasPermission({required PermissionType permissionType});
  EitherFailureOr<void> getPermission({required PermissionType permissionType});
}

class PermissionsHandlerRepositoryImpl
    with ErrorToFailureMixin
    implements PermissionsHandlerRepository {
  final PermissionsHandlerService _permissionsHandlerService;

  const PermissionsHandlerRepositoryImpl(this._permissionsHandlerService);

  @override
  EitherFailureOr<bool> hasPermission({
    required PermissionType permissionType,
  }) async =>
      Right(
        await _permissionsHandlerService.hasPermission(
          permissionType: permissionType,
        ),
      );

  @override
  EitherFailureOr<void> getPermission({
    required PermissionType permissionType,
  }) =>
      execute(
        () async {
          final hasPermission = await _permissionsHandlerService.hasPermission(
            permissionType: permissionType,
          );
          if (!hasPermission) {
            await _permissionsHandlerService.getPermission(
              permissionType: permissionType,
            );
          }
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );
}
