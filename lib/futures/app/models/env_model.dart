import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'converters/string_to_bool_converter.dart';

part 'env_model.freezed.dart';
part 'env_model.g.dart';

@freezed
@singleton
class EnvModel with _$EnvModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory EnvModel({
    required String env,
    @StringToBoolConverter() required bool debug,
    @StringToBoolConverter() required bool debugShowCheckedModeBanner,
    @StringToBoolConverter() required bool debugShowMaterialGrid,
    @StringToBoolConverter() required bool debugApiClient,
    required String restApiUrl,
  }) = _EnvModel;

  EnvModel._();

  factory EnvModel.fromJson(Map<String, dynamic> json) =>
      _$EnvModelFromJson(json);

  @factoryMethod
  @preResolve
  static Future<EnvModel> create() async {
    const env = String.fromEnvironment('APP_ENV', defaultValue: 'dev');

    await dotenv.load(fileName: '.env.$env');
    var envMap = dotenv.env;

    return EnvModel.fromJson(envMap);
  }

  bool get isRelease => env.split('_').contains('release');
}
