import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class AppRemoteDataSource {
  Future<void> logout();
}

@LazySingleton(as: AppRemoteDataSource)
class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  static const String _logoutPath = 'auth/logout';

  final Dio _client;
  AppRemoteDataSourceImpl({required Dio client}) : _client = client;

  @override
  Future<void> logout() async {
    // var result = await _client.post(_logoutPath);
    return Future.value(null);
  }
}
