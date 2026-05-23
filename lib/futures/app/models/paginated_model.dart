import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_model.freezed.dart';
part 'paginated_model.g.dart';

@freezed
abstract class PaginatedModel<T> with _$PaginatedModel<T> {
  @JsonSerializable(genericArgumentFactories: true)
  const factory PaginatedModel({
    @Default(100) int limit,
    @Default(0) int skip,
    @Default(100) int total,
    @Default([]) List<T> posts,
  }) = _PaginatedModel<T>;

  factory PaginatedModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$PaginatedModelFromJson<T>(json, fromJsonT);
  }
}
