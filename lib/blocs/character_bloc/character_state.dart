part of 'character_bloc.dart';

/// Extend Equatable For Unit Testing Purpose
class CharacterState extends Equatable {
  const CharacterState({
    this.dataState = DataState.loading,
    this.keyword = '',
    this.filterState,
    this.characterList,
    this.filteredCharacters = const []});
  
  final DataState dataState;
  final String keyword;
  final FilterState? filterState;
  final CharacterList? characterList;
  final List<Character> filteredCharacters;

  bool get isLoaded => dataState == DataState.loaded;
  bool get isLoading => dataState == DataState.loading;
  bool get isError => dataState == DataState.error;

  CharacterState copyWith({
    DataState? dataState,
    String? keyword,
    FilterState? filterState,
    CharacterList? characterList,
    List<Character>? filteredCharacters
  })=> CharacterState(
    dataState: dataState ?? this.dataState,
    keyword: keyword ?? this.keyword,
    filterState: filterState ?? this.filterState,
    characterList: characterList ?? this.characterList,
    filteredCharacters: filteredCharacters ?? this.filteredCharacters);

  @override
  List<Object?> get props => [
    dataState,
    keyword,
    filterState,
    characterList,
    filteredCharacters];
}