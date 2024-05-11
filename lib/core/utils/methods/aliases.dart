import '../../../futures/app/models/env_model.dart';
import '../../modules/dependency_injection/di.dart';
import '../helpers/logging_helper.dart';
import '../router.dart';

final LoggingHelper logIt = di<LoggingHelper>();
final EnvModel env = di<EnvModel>();
final AppRouter appRouter = di<AppRouter>();
