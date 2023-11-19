part of 'character_bloc.dart';

abstract class CharacterEvent {
  const CharacterEvent();
}

class GetListCharacter extends CharacterEvent {
  const GetListCharacter();
}

class ShowDetailsFromUrl extends CharacterEvent {
  final String url;
  final Function(Object data) onFinish;
  final Function() onError;
  const ShowDetailsFromUrl({
    required this.url,
    required this.onFinish,
    required this.onError});
}

class FilterAndSortListCharacter extends CharacterEvent {
  final FilterState filter;
  const FilterAndSortListCharacter(this.filter);
}

class SearchCharacter extends CharacterEvent {
  final String keyword;
  const SearchCharacter(this.keyword);
}

/// For Unit Testing Purpose
class TestGetListCharacter extends CharacterEvent {
  const TestGetListCharacter();
}