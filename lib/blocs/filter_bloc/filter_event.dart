part of 'filter_bloc.dart';

abstract class FilterEvent {
  const FilterEvent();
}

class SetFilters extends FilterEvent {
  final List<Gender> genders;
  const SetFilters({this.genders = const []});
}

class SetSort extends FilterEvent {
  final Sort sort;
  const SetSort(this.sort);
}
