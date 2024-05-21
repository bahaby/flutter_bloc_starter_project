import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants.dart';
import '../../../models/alert_model.dart';
import '../../../../../core/data/data_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_list_event.dart';
part 'generic_list_state.dart';
part 'generic_list_bloc.freezed.dart';

class GenericListBloc<T>
    extends Bloc<GenericListEvent<T>, GenericListState<T>> {
  final _limit = constants.api.maxItemToBeFetchedAtOneTime;
  final DataRepository<T> _repository;
  GenericListBloc({
    required DataRepository<T> repository,
  })  : _repository = repository,
        super(GenericListState<T>.initial()) {
    on<GenericListEvent<T>>((event, emit) async {
      switch (event) {
        case _Refresh():
          emit(const GenericListState.loading());
          final result = await _repository.list(limit: _limit, skip: 0);
          result.fold(
            (left) => emit(GenericListState.failed(left)),
            (right) {
              final hasMore = right.total > right.items.length;
              emit(GenericListState.loaded(right.items, hasMore: hasMore));
            },
          );
          break;
        case _LoadMore(:final items):
          final lastState = state;
          final skip = items.length;
          emit(GenericListState<T>.loadingMore(items));
          final result = await _repository.list(limit: _limit, skip: skip);
          result.fold(
            (left) {
              emit(GenericListState<T>.failed(left));
              emit(lastState);
            },
            (right) {
              final newPosts = items + right.items;
              final hasMore = right.total > newPosts.length;
              emit(GenericListState<T>.loaded(newPosts, hasMore: hasMore));
            },
          );
          break;
      }
    });
  }
}
