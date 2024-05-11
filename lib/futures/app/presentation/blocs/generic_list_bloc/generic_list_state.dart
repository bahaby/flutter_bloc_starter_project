part of 'generic_list_bloc.dart';

@freezed
class GenericListState<T> with _$GenericListState<T> {
  const factory GenericListState.initial() = Initial;
  const factory GenericListState.loading() = Loading;
  const factory GenericListState.loadingMore(List<T> items) = LoadingMore<T>;
  const factory GenericListState.loaded(
    List<T> items, {
    @Default(true) bool hasMore,
  }) = Loaded<T>;
  const factory GenericListState.failed(AlertModel alert) = Failed;
}
