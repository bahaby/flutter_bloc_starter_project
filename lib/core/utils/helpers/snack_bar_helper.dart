import 'package:flutter/material.dart';
import 'package:flutter_bloc_starter_project/core/utils/extensions/build_context_extensions.dart';
import '../../../futures/app/models/alert_model.dart';
import '../../generated/translations.g.dart';

@immutable
class SnackBarHelper {
  const SnackBarHelper._();

  static void showAlert(BuildContext context, {required AlertModel alert}) {
    String message;

    if (alert.translatable) {
      message = context.tr[alert.message];
    } else {
      message = alert.message;
    }
    var snackbar = _createSnackbar(context, message, alert.type);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static SnackBar _createSnackbar(
    BuildContext context,
    String message,
    AlertType type,
  ) {
    IconData? icon;
    Color backgroundColor;

    switch (type) {
      case AlertType.constructive:
        icon = Icons.check_circle;
        backgroundColor = const Color(0xFF40DBA3);
        break;
      case AlertType.destructive:
        icon = Icons.error;
        backgroundColor = const Color(0xFFE4756D);
        break;
      case AlertType.error:
        icon = Icons.error;
        backgroundColor = Colors.red;
        break;
      case AlertType.notification:
        icon = Icons.notifications;
        backgroundColor = Colors.grey;
        break;
      default:
        icon = Icons.info;
        backgroundColor = Colors.red;
        break;
    }

    return SnackBar(
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: Colors.white),
          ),
          Expanded(
            child: Text(message,
                softWrap: true,
                style: context.textThemeScheme.bodyMedium
                    ?.copyWith(color: Colors.white)),
          ),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: backgroundColor,
    );
  }
}
