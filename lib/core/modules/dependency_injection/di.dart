import '../../../futures/app/models/auth_model.dart';
import 'di.config.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final di = GetIt.instance;

@InjectableInit(
  ignoreUnregisteredTypes: [TokenStorage<AuthModel>],
)
void configureDependencyInjection() => di.init();
