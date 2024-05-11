import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class PermissionHelper {
  static Future<Map<Permission, PermissionStatus>> checkPermissions(
    List<Permission> permissions,
  ) async {
    final Map<Permission, PermissionStatus> statuses = {};

    for (final permission in permissions) {
      statuses[permission] = await permission.status;
    }

    return statuses;
  }

  static Future<bool> grantPermission(
    Permission permission, {
    VoidCallback? onGranted,
    VoidCallback? onDenied,
    VoidCallback? onPermanentlyDenied,
    bool showRationale = true,
  }) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await permission.request();

      if (status.isGranted) {
        if (onGranted != null) {
          onGranted();
        }
        return true;
      } else if (status.isPermanentlyDenied) {
        if (showRationale) {
          openAppSettings();
        }
        if (onPermanentlyDenied != null) {
          onPermanentlyDenied();
        }
      } else {
        if (onDenied != null) {
          onDenied();
        }
      }
    }
    return false;
  }
}
