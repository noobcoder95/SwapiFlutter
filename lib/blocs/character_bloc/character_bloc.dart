import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swapi_flutter/blocs/filter_bloc/filter_bloc.dart';
import 'package:swapi_flutter/data/models/character.dart';
import 'package:swapi_flutter/data/models/character_list.dart';
import 'package:swapi_flutter/data/repository.dart';
import 'package:swapi_flutter/main.dart';
import 'package:swapi_flutter/utils/app_helpers.dart';
import 'package:swapi_flutter/utils/enums/data_state.dart';
import 'package:swapi_flutter/utils/enums/gender.dart';
import 'package:swapi_flutter/utils/enums/sort.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc({CharacterState? initialState}) : super(const CharacterState()) {
    on<GetListCharacter>(_getListCharacter);
    on<FilterAndSortListCharacter>(_filterAndSortListCharacter);
    on<TestGetListCharacter>(_testGetListCharacter);
    on<ShowDetailsFromUrl>(_showDetailsFromUrl);
    on<SearchCharacter>(_searchCharacter);
  }

  Repository get repository => di.get<Repository>();
  
  Future<void> _getListCharacter(
      GetListCharacter event,
      Emitter<CharacterState> emitter) async {
    emitter(state.copyWith(dataState: DataState.loading));
    final path = state.characterList?.next ?? 'https://swapi.dev/api/people/';
    final response = await repository.getData(path);
    if(response.data != null) {
      final data = CharacterList.fromJson(response.data);
      final List<Character> characters = [];
      final List<Character> filteredCharacters = [];

      if(state.characterList != null && state.characterList!.results.isNotEmpty) {
        characters.addAll(state.characterList!.results);
      }

      for(var i in data.results) {
        if(characters.where((e) => e.url == i.url).isEmpty) {
          characters.add(i);
        }
      }

      final characterList = data.copyWith(results: characters);

      /// Filter character based on filter state
      filteredCharacters.addAll(characters.where((e) {
        if((state.filterState ?? const FilterState()).genders.isEmpty) {
          return Gender.values.contains(e.genderEnum);
        }
        return (state.filterState ?? const FilterState()).genders.contains(e.genderEnum);
      }));

      /// Filter character based on keyword
      if(state.keyword.isNotEmpty) {
        final List<Character> searchedCharacters = [];
        searchedCharacters.addAll(filteredCharacters
            .where((e) => e.name.toLowerCase().contains(state.keyword)));
        filteredCharacters.clear();
        filteredCharacters.addAll(searchedCharacters);
      }

      /// Sort character
      if(filteredCharacters.isNotEmpty) {
        if(state.filterState?.sort == Sort.descending) {
          filteredCharacters.sort((a, b)=> b.name.compareTo(a.name));
        } else {
          filteredCharacters.sort((a, b)=> a.name.compareTo(b.name));
        }
      }

      bool isFetchAgain = filteredCharacters.length == state.filteredCharacters.length;

      emitter(state.copyWith(
          characterList: characterList,
          filteredCharacters: isFetchAgain
              ? null : filteredCharacters,
          dataState: DataState.loaded));

      if(isFetchAgain) {
        add(const GetListCharacter());
      }
    } else {
      AppHelpers.showSnackBar(message: response.message);
      emitter(state.copyWith(
          dataState: state.filteredCharacters.isNotEmpty
              ? DataState.loaded /// Keep showing existed data
              : DataState.error /// Show the list is empty
      ));
    }
  }

  Future<void> _showDetailsFromUrl(
      ShowDetailsFromUrl event,
      Emitter<CharacterState> emitter) async {
    final response = await repository.getData(event.url);
    if(response.data != null) {
      event.onFinish(response.data);
    } else {
      event.onError();
      AppHelpers.showSnackBar(message: response.message);
    }
  }

  void _filterAndSortListCharacter(
      FilterAndSortListCharacter event,
      Emitter<CharacterState> emitter) {
    if((state.characterList?.results ?? <Character>[]).isNotEmpty) {
      final List<Character> characters = [];
      /// Filter character based on filter state
      characters.addAll(state.characterList!.results.where((e) {
        if(event.filter.genders.isEmpty) {
          return Gender.values.contains(e.genderEnum);
        }
        return event.filter.genders.contains(e.genderEnum);
      }));

      /// Filter character based on keyword
      if(state.keyword.isNotEmpty) {
        final List<Character> searchedCharacters = [];
        searchedCharacters.addAll(characters
            .where((e) => e.name.toLowerCase().contains(state.keyword)));
        characters.clear();
        characters.addAll(searchedCharacters);
      }

      /// Sort character
      if(characters.isNotEmpty) {
        if(event.filter.sort == Sort.descending) {
          characters.sort((a, b)=> b.name.compareTo(a.name));
        } else {
          characters.sort((a, b)=> a.name.compareTo(b.name));
        }
      }
      emitter(state.copyWith(filterState: event.filter, filteredCharacters: characters));
    }
  }

  void _searchCharacter(
      SearchCharacter event,
      Emitter<CharacterState> emitter) {
    emitter(state.copyWith(keyword: event.keyword));
    add(FilterAndSortListCharacter(state.filterState ?? const FilterState()));
  }

  /// For Unit Testing Purpose
  Future<void> _testGetListCharacter(
      TestGetListCharacter event,
      Emitter<CharacterState> emitter) async {
    emitter(state.copyWith(dataState: DataState.loading));
    final sampleData = {
      "count": 82,
      "next": "https://swapi.dev/api/people/?page=2",
      "previous": null,
      "results": [
        {
          "name": "Luke Skywalker",
          "height": "172",
          "mass": "77",
          "hair_color": "blond",
          "skin_color": "fair",
          "eye_color": "blue",
          "birth_year": "19BBY",
          "gender": "male",
          "homeworld": "https://swapi.dev/api/planets/1/",
          "films": [
            "https://swapi.dev/api/films/1/",
            "https://swapi.dev/api/films/2/",
            "https://swapi.dev/api/films/3/",
            "https://swapi.dev/api/films/6/"
          ],
          "species": [],
          "vehicles": [
            "https://swapi.dev/api/vehicles/14/",
            "https://swapi.dev/api/vehicles/30/"
          ],
          "starships": [
            "https://swapi.dev/api/starships/12/",
            "https://swapi.dev/api/starships/22/"
          ],
          "created": "2014-12-09T13:50:51.644000Z",
          "edited": "2014-12-20T21:17:56.891000Z",
          "url": "https://swapi.dev/api/people/1/"
        },
        {}
      ]
    };
    final characterList = CharacterList.fromJson(sampleData);
    emitter(state.copyWith(dataState: DataState.loaded, characterList: characterList));
  }
}