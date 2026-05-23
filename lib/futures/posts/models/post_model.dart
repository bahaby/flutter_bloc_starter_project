import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class ReactionsModel with _$ReactionsModel {
  factory ReactionsModel({required int likes, required int dislikes}) =
      _ReactionsModel;

  factory ReactionsModel.initial() => ReactionsModel(likes: 0, dislikes: 0);
  factory ReactionsModel.fromJson(Map<String, dynamic> json) =>
      _$ReactionsModelFromJson(json);
}

@freezed
abstract class PostModel with _$PostModel {
  factory PostModel({
    required int id,
    required String title,
    required String body,
    required int userId,
    required List<String> tags,
    required ReactionsModel reactions,
    required int views,
  }) = _PostModel;

  factory PostModel.initial() => PostModel(
    id: 0,
    title: '',
    body: '',
    userId: 0,
    tags: <String>[],
    reactions: ReactionsModel.initial(),
    views: 0,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
