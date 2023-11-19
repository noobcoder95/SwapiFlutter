import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swapi_flutter/blocs/character_bloc/character_bloc.dart';
import 'package:swapi_flutter/blocs/filter_bloc/filter_bloc.dart';
import 'package:swapi_flutter/localizations/locale_keys.g.dart';
import 'package:swapi_flutter/utils/enums/gender.dart';
import 'package:swapi_flutter/utils/enums/sort.dart';
import 'package:swapi_flutter/utils/extension/build_context.dart';
import 'package:swapi_flutter/utils/extension/gender.dart';

class FilterSortBottomSheet extends StatelessWidget {
  final FilterBloc filterBloc;
  final CharacterBloc characterBloc;
  const FilterSortBottomSheet({
    super.key,
    required this.filterBloc,
    required this.characterBloc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)
          )
      ),
      child: Stack(
        children: [
          BlocBuilder<FilterBloc, FilterState>(
            bloc: filterBloc,
            builder: (context, state) {
              return ListView(
                children: [
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      LocaleKeys.filterByGender.tr(),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  ...Gender.values.map((e) {
                    return CheckboxListTile(
                        title: Text(tr(e.label)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        value: state.genders.where((v) => v == e).isNotEmpty,
                        onChanged: (v) {
                          final List<Gender> genders = [];
                          genders.addAll(state.genders);
                          if(state.genders.where((g) => g == e).isNotEmpty) {
                            genders.remove(e);
                          } else {
                            genders.add(e);
                          }
                          filterBloc.add(SetFilters(genders: genders));
                        }
                    );
                  }).toList(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10
                    ),
                    child: Text(
                      LocaleKeys.sortByName.tr(),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  ...Sort.values.map((e) {
                    return RadioListTile(
                        title: Text(tr(e.name)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        value: e,
                        groupValue: state.sort,
                        onChanged: (v) => filterBloc.add(SetSort(e))
                    );
                  }).toList()
                ],
              );
            },
          ),
          Positioned(
            top: 0,
            child: Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)
                  )
              ),
              margin: EdgeInsets.zero,
              child: Container(
                width: context.maxBottomSheetWidth,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.filtersAndSort.tr(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        filterBloc.add(SetSort(
                            characterBloc.state.filterState?.sort ?? Sort.ascending));
                        filterBloc.add(SetFilters(
                            genders: characterBloc.state.filterState?.genders ?? []));
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: context.maxBottomSheetWidth,
              decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, -1.0),
                      blurRadius: 6.0,
                    ),
                  ]
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: MaterialButton(
                  color: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    characterBloc.add(FilterAndSortListCharacter(filterBloc.state));
                    Navigator.pop(context);
                  },
                  child: Text(
                    LocaleKeys.showResult.tr(),
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.background),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}