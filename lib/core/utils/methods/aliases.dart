import '../../../futures/app/models/env_model.dart';
import '../../modules/dependency_injection/di.dart';
import '../helpers/logging_helper.dart';
import '../router.dart';

LoggingHelper get logIt => di<LoggingHelper>();
EnvModel get env => di<EnvModel>();
AppRouter get appRouter => di<AppRouter>();
