import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';

import '../../utils/methods/aliases.dart';

Future<void> initializeSentry() async {
  final dsn = env.env == 'dev'
      ? 'WRONG_DSN_DISABLES_SENTRY_INITILIZATION'
      : 'ENTER_YOUR_SENTRY_URL';

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = dsn
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        ..tracesSampleRate = 1.0
        ..environment = env.env;
    },
  );
}
