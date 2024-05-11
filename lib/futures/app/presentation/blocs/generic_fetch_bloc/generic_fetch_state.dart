part of 'generic_fetch_bloc.dart';

@freezed
class GenericFetchState<T> with _$GenericFetchState<T> {
  const factory GenericFetchState.initial() = Initial;
  const factory GenericFetchState.loading() = Loading;
  const factory GenericFetchState.loaded(T item) = Loaded<T>;
  const factory GenericFetchState.failed(AlertModel alert) = Failed;
}
