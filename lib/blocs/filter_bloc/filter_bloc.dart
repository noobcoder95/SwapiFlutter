import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swapi_flutter/utils/enums/gender.dart';
import 'package:swapi_flutter/utils/enums/sort.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({FilterState? initialState}) : super(const FilterState()) {
    on<SetFilters>(_setFilters);
    on<SetSort>(_setSort);
  }

  _setFilters(
      SetFilters event,
      Emitter<FilterState> emitter) {
    emitter(state.copyWith(genders: event.genders));
  }

  _setSort(
      SetSort event,
      Emitter<FilterState> emitter) {
    emitter(state.copyWith(sort: event.sort));
  }
}