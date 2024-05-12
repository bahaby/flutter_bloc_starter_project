import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  factory PostModel({
    required int id,
    required String title,
    required String body,
    required int userId,
    required List<String> tags,
    required int reactions,
  }) = _PostModel;

  factory PostModel.initial() => PostModel(
        id: 0,
        title: '',
        body: '',
        userId: 0,
        tags: <String>[],
        reactions: 0,
      );

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
