import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,
    required String email,
    required String image,
  }) = _UserModel;

  factory UserModel.initial() => const UserModel(
        id: 0,
        username: '',
        email: '',
        image: '',
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
