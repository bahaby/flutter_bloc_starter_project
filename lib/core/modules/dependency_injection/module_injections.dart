import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/objectbox.g.dart';
import '../dio/dio_client.dart';
import '../token_refresh/dio_token_refresh.dart';

@module
abstract class ModuleInjections {
  @preResolve
  Future<Store> getStore() async {
    final dir = await getApplicationDocumentsDirectory();

    return Store(getObjectBoxModel(), directory: '${dir.path}/objectbox');
  }

  FlutterSecureStorage storage() => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );

  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  InternetConnection networkInfo() => InternetConnection.createInstance(
      // to add custom uri for checking internet connection
      /* customCheckOptions: [
      InternetCheckOption(uri: Uri.parse('https://www.google.com')),
    ], */
      );

  Dio dio(
    DioTokenRefresh dioTokenRefresh,
    InternetConnection networkInfo,
  ) =>
      initDioClient(dioTokenRefresh, networkInfo);
}
