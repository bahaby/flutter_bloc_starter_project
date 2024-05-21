import '../../app/models/alert_model.dart';
import '../../app/models/auth_model.dart';
import '../../app/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/exception_handler.dart';
import '../../../core/modules/token_refresh/dio_token_refresh.dart';
import '../../app/repositories/app_repository.dart';
import '../sources/auth_remote_data_source.dart';

@LazySingleton()
class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final DioTokenRefresh _dioTokenRefresh;
  final AppRepository _appRepository;

  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required DioTokenRefresh dioTokenRefresh,
    required AppRepository appRepository,
  })  : _remoteDataSource = remoteDataSource,
        _dioTokenRefresh = dioTokenRefresh,
        _appRepository = appRepository;

  @override
  Future<Either<AlertModel, AuthModel>> login({
    required String email,
    required String password,
  }) {
    return exceptionHandler(() async {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      _onAuthSuccess(result);
      return right(result);
    });
  }

  @override
  Future<Either<AlertModel, UserModel>> getUser() async {
    return exceptionHandler(() async {
      final user = (await _dioTokenRefresh.fresh.token)?.user;
      if (user != null) {
        return right(user);
      }

      final result = await _remoteDataSource.getLoggedUser();
      return right(result);
    });
  }

  _onAuthSuccess(AuthModel auth) async {
    await _dioTokenRefresh.fresh.setToken(auth);
    final loggedUser = await _remoteDataSource.getLoggedUser();
    await _dioTokenRefresh.fresh.setToken(auth.copyWith(user: loggedUser));
    _appRepository.setLoggedUser(user: loggedUser);
  }
}
