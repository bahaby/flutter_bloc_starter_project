import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class AuthModel with _$AuthModel {
  const factory AuthModel({
    @Default('Bearer') String tokenType,
    @Default('') String accessToken,
    @Default('') String refreshToken,
    required int id,
    required String username,
    required String email,
    required String image,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
