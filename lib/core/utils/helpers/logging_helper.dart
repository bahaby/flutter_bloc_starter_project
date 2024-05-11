import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../methods/aliases.dart';

@singleton
class LoggingHelper {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: constants.debug.maxLogLines,
      colors: false,
    ),
  );

  void _log(Level level, dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    if (env.isRelease && !showInProd) {
      return;
    }

    _logger.log(level, message, error: error, stackTrace: stackTrace);
  }

  void trace(dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    _log(Level.trace, message,
        error: error, showInProd: showInProd, stackTrace: stackTrace);
  }

  void debug(dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    _log(Level.debug, message,
        error: error, showInProd: showInProd, stackTrace: stackTrace);
  }

  void info(dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    _log(Level.info, message,
        error: error, showInProd: showInProd, stackTrace: stackTrace);
  }

  void warn(dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    _log(Level.warning, message,
        error: error, showInProd: showInProd, stackTrace: stackTrace);
  }

  void error(dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    _log(Level.error, message,
        error: error, showInProd: showInProd, stackTrace: stackTrace);
  }

  void fatal(dynamic message,
      {dynamic error, bool showInProd = false, StackTrace? stackTrace}) {
    _log(Level.fatal, message,
        error: error, showInProd: showInProd, stackTrace: stackTrace);
  }
}
