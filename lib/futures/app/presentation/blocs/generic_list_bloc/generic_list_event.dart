part of 'generic_list_bloc.dart';

@freezed
class GenericListEvent<T> with _$GenericListEvent<T> {
  const factory GenericListEvent.refresh() = _Refresh;
  const factory GenericListEvent.loadMore(List<T> items) = _LoadMore<T>;
}
