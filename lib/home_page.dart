import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swapi_flutter/blocs/character_bloc/character_bloc.dart';
import 'package:swapi_flutter/data/models/character.dart';
import 'package:swapi_flutter/data/models/home_world.dart';
import 'package:swapi_flutter/data/models/vehicle.dart';
import 'package:swapi_flutter/utils/assets.dart';
import 'package:swapi_flutter/utils/extension/build_context.dart';
import 'package:swapi_flutter/widgets/app_shimmer.dart';
import 'package:swapi_flutter/widgets/character_card.dart';
import 'package:swapi_flutter/widgets/detail_dialog.dart';
import 'package:swapi_flutter/widgets/filter_sort_bottom_sheet.dart';

import 'blocs/filter_bloc/filter_bloc.dart';
import 'data/models/starship.dart';
import 'localizations/locale_keys.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final CharacterBloc _characterBloc = CharacterBloc();
  final FilterBloc _filterBloc = FilterBloc();
  final ValueNotifier<bool> _showOverlay = ValueNotifier(false);

  @override
  void initState() {
    _characterBloc.add(const GetListCharacter());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: context.screenWidth,
            child: Container(
              color: theme.colorScheme.secondary,
              alignment: Alignment.topCenter,
              child: SizedBox(
                /// Force mobile layout in web platform
                width: context.maxAllowedWidth,
                child: Stack(
                  children: [
                    _characterList(theme),
                    _searchAndFilter(theme),
                    _overlayContainer(theme)
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _characterList(ThemeData theme) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: BlocBuilder<CharacterBloc, CharacterState>(
        bloc: _characterBloc,
        builder: (context, state) {
          if(state.isError
              || (state.isLoaded
                  && state.filteredCharacters.isEmpty)) {
            return Center(
              child: Image.asset(Assets.emptyItemImage),
            );
          }

          return ListView.separated(
            separatorBuilder: (_, i) => const SizedBox(height: 10),
            itemCount: state.isLoading && state.filteredCharacters.isEmpty
                ? 5
                : state.filteredCharacters.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final margin = index == 0
                  ? const EdgeInsets.only(top: 80)
                  : index == (state.filteredCharacters.length - 1)
                  ? const EdgeInsets.only(bottom: 20)
                  : theme.cardTheme.margin;

              if(state.isLoading && state.filteredCharacters.isEmpty) {
                return Card(
                    margin: margin,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: AppShimmer(height: 300));
              }

              return Column(
                children: [
                  _characterCard(
                      character: state.filteredCharacters[index],
                      margin: margin
                  ),
                  if(index == (state.filteredCharacters.length - 1))
                    ...[
                      if(!state.isLoading
                          && state.filteredCharacters.isNotEmpty
                          && (state.characterList?.next ?? '').isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.background,
                              foregroundColor: theme.colorScheme.primary
                            ),
                            onPressed: ()=> _characterBloc.add(const GetListCharacter()),
                            child: Text(LocaleKeys.showMore.tr()),
                          ),
                        ),
                      if(state.isLoading
                          && state.filteredCharacters.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(20)),
                        )
                    ]
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _searchAndFilter(ThemeData theme) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<CharacterBloc, CharacterState>(
          bloc: _characterBloc,
          builder: (context, state) {
            if(state.isLoading && state.filteredCharacters.isEmpty) {
              return Row(
                children: [
                  Expanded(
                    child: AppShimmer(height: 60),
                  ),
                  const SizedBox(width: 20),
                  AppShimmer(
                    height: 60,
                    width: 60,
                  )
                ],
              );
            }
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (v) => _characterBloc.add(SearchCharacter(v)),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: theme.colorScheme.primary,
                        )
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _showFilterAndSort(),
                  icon: Icon(
                    FontAwesomeIcons.filter,
                    color: theme.colorScheme.primary,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _overlayContainer(ThemeData theme) {
    return ValueListenableBuilder(
      valueListenable: _showOverlay,
      builder: (context, show, child) {
        if(!show) {
          return const SizedBox();
        }
        return Container(
          color: theme.colorScheme.onSurface.withOpacity(.7),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  '${LocaleKeys.pleaseWait.tr()}...',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _characterCard({
    required Character character,
    EdgeInsetsGeometry? margin}) {
    return CharacterCard(
      margin: margin,
      data: character,
      onHomeworldPressed: () {
        _showOverlay.value = true;
        _characterBloc.add(ShowDetailsFromUrl(
            url: character.homeworld,
            onError: ()=> _showOverlay.value = false,
            onFinish: (data) {
              final homeworld = HomeWorld.fromJson(data);
              _showOverlay.value = false;
              DetailDialog.show(context: context, data: homeworld);
            }
        ));
      },
      onStarshipPressed: () {
        _showOverlay.value = true;
        showDetail(String url) {
          if(character.starships.length > 1) {
            Navigator.of(context).pop();
          }
          _characterBloc.add(ShowDetailsFromUrl(
              url: url,
              onError: ()=> _showOverlay.value = false,
              onFinish: (data) {
                final starship = Starship.fromJson(data);
                _showOverlay.value = false;
                DetailDialog.show(context: context, data: starship);
              }
          ));
        }

        if(character.starships.length > 1) {
          int order = 0;
          _showOption(
              title: LocaleKeys.chooseStarship.tr(),
              options: character.starships.map((e) {
                order++;
                return ListTile(
                  onTap: ()=> showDetail(e),
                  title: Text(
                      '${LocaleKeys.starship.tr()} $order'
                  ),
                );
              }).toList()
          );
        } else {
          showDetail(character.starships.first);
        }
      },
      onVehiclePressed: () {
        _showOverlay.value = true;
        showDetail(String url) {
          if(character.vehicles.length > 1) {
            Navigator.of(context).pop();
          }
          _characterBloc.add(ShowDetailsFromUrl(
              url: url,
              onError: ()=> _showOverlay.value = false,
              onFinish: (data) {
                final vehicle = Vehicle.fromJson(data);
                _showOverlay.value = false;
                DetailDialog.show(context: context, data: vehicle);
              }
          ));
        }

        if(character.vehicles.length > 1) {
          int order = 0;
          _showOption(
              title: LocaleKeys.chooseVehicle.tr(),
              options: character.vehicles.map((e) {
                order++;
                return ListTile(
                  onTap: ()=> showDetail(e),
                  title: Text(
                      '${LocaleKeys.vehicle.tr()} $order'
                  ),
                );
              }).toList()
          );
        } else {
          showDetail(character.vehicles.first);
        }
      },
    );
  }

  void _showFilterAndSort() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: false,
        builder: (context) {
          return FilterSortBottomSheet(
            filterBloc: _filterBloc,
            characterBloc: _characterBloc,
          );
        });
  }

  void _showOption({
    required String title,
    required List<Widget> options}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...options
            ],
          );
        });
  }
}