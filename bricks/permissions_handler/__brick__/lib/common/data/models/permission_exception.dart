import 'package:{{project_name.snakeCase()}}/common/data/services/permissions_handler_service.dart';

class PermissionException implements Exception {
  final PermissionType permissionType;
  final PermissionErrorType permissionErrorType;

  PermissionException({
    required this.permissionType,
    required this.permissionErrorType,
  });
}
