import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  @Entity(realClass: PostModel)
  factory PostModel({
    @Id(assignable: true) required int id,
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
