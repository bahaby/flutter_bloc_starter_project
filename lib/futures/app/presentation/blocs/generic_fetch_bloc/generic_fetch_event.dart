part of 'generic_fetch_bloc.dart';

@freezed
class GenericFetchEvent<T> with _$GenericFetchEvent<T> {
  const factory GenericFetchEvent.refresh(int id) = _Refresh;
}
