import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swapi_flutter/blocs/character_bloc/character_bloc.dart';
import 'package:swapi_flutter/data/models/character.dart';
import 'package:swapi_flutter/data/models/character_list.dart';
import 'package:swapi_flutter/utils/enums/data_state.dart';

void main() {
  group('Character Bloc Test', () {
    final CharacterBloc bloc = CharacterBloc();
    const CharacterList sampleData = CharacterList(
      count: 82,
      next: "https://swapi.dev/api/people/?page=2",
      results: [
        Character(
          name: "Luke Skywalker",
          gender: "male",
          homeworld: "https://swapi.dev/api/planets/1/",
          url: "https://swapi.dev/api/people/1/",
          vehicles: [
            "https://swapi.dev/api/vehicles/14/",
            "https://swapi.dev/api/vehicles/30/"
          ],
          starships: [
            "https://swapi.dev/api/starships/12/",
            "https://swapi.dev/api/starships/22/"
          ],
        ),
        Character()
      ]
    );

    blocTest<CharacterBloc, CharacterState>(
      'Test Get List Character',
      build: () => bloc,
      act: (bloc) => bloc.add(const TestGetListCharacter()),
      expect: () => [
        const CharacterState(),
        const CharacterState(
          dataState: DataState.loaded,
          characterList: sampleData
        )
      ]
    );
    
    tearDown(() => bloc.close());
  });
}
