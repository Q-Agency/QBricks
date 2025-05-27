import 'package:permission_handler/permission_handler.dart';

import 'package:{{project_name.snakeCase()}}/common/data/models/permission_exception.dart';

abstract interface class PermissionsHandlerService {
  Future<bool> hasPermission({required PermissionType permissionType});

  Future<void> getPermission({required PermissionType permissionType});
}

class PermissionsHandlerServiceImpl implements PermissionsHandlerService {
  PermissionsHandlerServiceImpl();

  @override
  Future<bool> hasPermission({required PermissionType permissionType}) async {
    final permission = permissionType.convertToPermission;
    if (permission is PermissionWithService) {
      final serviceStatus = await permission.serviceStatus;
      if (serviceStatus.isDisabled) return false;
    }
    final status = await permission.status;
    return status.isGranted || status.isLimited || status.isProvisional;
  }

  @override
  Future<void> getPermission({required PermissionType permissionType}) async {
    final permission = permissionType.convertToPermission;
    if (permission is PermissionWithService) {
      final serviceStatus = await permission.serviceStatus;
      if (serviceStatus.isDisabled) {
        throw PermissionException(
          permissionType: permissionType,
          permissionErrorType: PermissionErrorType.serviceDisabled,
        );
      }
    }
    final status = await permission.request();
    if (status.isDenied) {
      throw PermissionException(
        permissionType: permissionType,
        permissionErrorType: PermissionErrorType.denied,
      );
    }
    if (status.isPermanentlyDenied) {
      throw PermissionException(
        permissionType: permissionType,
        permissionErrorType: PermissionErrorType.deniedPermanently,
      );
    }
  }
}

enum PermissionType {
  photos;

  Permission get convertToPermission => switch (this) {
        photos => Permission.photos,
      };

  String errorMessage({required PermissionErrorType permissionErrorType}) {
    return switch (permissionErrorType) {
      PermissionErrorType.serviceDisabled =>
        '$name services are disabled, please enable them in device settings',
      PermissionErrorType.denied => '$name permissions are denied',
      PermissionErrorType.deniedPermanently =>
        '$name permissions are permanently denied, please enable them in device settings for this application',
    }; // TODO: move these strings to .arb files
  }
}

enum PermissionErrorType {
  serviceDisabled,
  denied,
  deniedPermanently;
}
