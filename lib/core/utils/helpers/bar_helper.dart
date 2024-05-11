import 'package:flutter/material.dart';
import '../../../futures/app/models/alert_model.dart';
import '../../../futures/app/presentation/widgets/bar/bar.dart';
import '../../generated/translations.g.dart';

@immutable
abstract class BarHelper {
  const BarHelper._();

  static void showNetworkAlert(
    BuildContext context, {
    required bool isConnected,
  }) {
    final message = isConnected
        ? context.tr.core.status.connected
        : context.tr.core.status.disconnected;
    final color =
        isConnected ? const Color(0xFF40DBA3) : const Color(0xFFE4756D);
    final iconData = isConnected ? Icons.check_circle : Icons.error;
    final bar = _createAlertModal(
      message: message,
      iconWidget: Icon(
        iconData,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 1),
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.all(Radius.zero),
      messageSize: 16,
      color: color,
      barPosition: BarPosition.bottom,
    );

    bar.show(context);
  }

  static void showAlert(
    BuildContext context, {
    required AlertModel alert,
    BarPosition barPosition = BarPosition.top,
  }) {
    Bar<void> bar;
    final String message =
        alert.translatable ? context.tr[alert.message] : alert.message;

    if (alert.type == AlertType.constructive) {
      bar = _createAlertModal(
        message: message,
        iconWidget: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        color: const Color(0xFF40DBA3),
        barPosition: barPosition,
      );
    } else if (alert.type == AlertType.destructive) {
      bar = _createAlertModal(
        message: message,
        iconWidget: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        color: const Color(0xFFE4756D),
        barPosition: barPosition,
      );
    } else if (alert.type == AlertType.error) {
      bar = _createAlertModal(
        message: message,
        iconWidget: const SizedBox(),
        color: Colors.red,
        barPosition: barPosition,
      );
    } else if (alert.type == AlertType.notification) {
      bar = _createAlertModal(
        message: message,
        color: Colors.grey,
        iconWidget: Container(
          height: 24,
          width: 24,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
                BorderSide(color: Colors.white, width: 2)),
          ),
          margin: const EdgeInsets.all(4),
        ),
        barPosition: barPosition,
      );
    } else if (alert.type == AlertType.quiet) {
      return;
    } else {
      bar = _createAlertModal(
          message: message,
          iconWidget: const SizedBox(),
          color: Colors.red,
          barPosition: barPosition);
    }

    bar.show(context);
  }

  static Bar<void> _createAlertModal({
    required String message,
    required Widget iconWidget,
    required Color color,
    required BarPosition barPosition,
    double maxHeight = 60,
    double messageSize = 18,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    EdgeInsets margin = const EdgeInsets.all(8),
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Bar<void>(
      title: title,
      message: message,
      barPosition: barPosition,
      icon: iconWidget,
      maxHeight: maxHeight,
      backgroundColor: color,
      messageSize: messageSize,
      borderRadius: borderRadius,
      margin: margin,
      shouldIconPulse: false,
      isDismissible: true,
      duration: duration,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
