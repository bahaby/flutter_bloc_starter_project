import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_model.freezed.dart';
part 'paginated_model.g.dart';

@freezed
@JsonSerializable(genericArgumentFactories: true)
class PaginatedModel<T> with _$PaginatedModel<T> {
  const factory PaginatedModel({
    required int limit,
    required int skip,
    required int total,
    required List<T> posts,
  }) = _PaginatedModel;

  factory PaginatedModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$PaginatedModelFromJson<T>(json, fromJsonT);
  }

  factory PaginatedModel.initial() =>
      PaginatedModel<T>(skip: 0, limit: 100, total: 100, posts: <T>[]);
}
