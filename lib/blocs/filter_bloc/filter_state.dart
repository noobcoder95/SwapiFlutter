part of 'filter_bloc.dart';

class FilterState {
  const FilterState({
    this.genders = const [],
    this.sort = Sort.ascending,});

  final List<Gender> genders;
  final Sort sort;

  FilterState copyWith({
    List<Gender>? genders,
    Sort? sort
  })=> FilterState(
    genders: genders ?? this.genders,
    sort: sort ?? this.sort);
}