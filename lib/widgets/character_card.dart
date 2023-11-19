import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swapi_flutter/data/models/character.dart';
import 'package:swapi_flutter/localizations/locale_keys.g.dart';
import 'package:swapi_flutter/utils/extension/string.dart';
import 'package:swapi_flutter/widgets/custom_badge.dart';

class CharacterCard extends StatelessWidget {
  final Character data;
  final EdgeInsetsGeometry? margin;
  final Function()? onHomeworldPressed;
  final Function()? onStarshipPressed;
  final Function()? onVehiclePressed;
  const CharacterCard({
    super.key,
    required this.data,
    this.margin,
    this.onHomeworldPressed,
    this.onStarshipPressed,
    this.onVehiclePressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomBadge(
              width: 120,
              height: 120,
              label: data.name.initialCase,
              textStyle: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.background),
            ),
            Text(
              data.name.replaceIfEmpty,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              tr(data.gender.replaceIfEmpty),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            if(data.homeworld.isNotEmpty)
              FilledButton(
                onPressed: onHomeworldPressed,
                child: Text(
                  LocaleKeys.homeworld.tr().toUpperCase(),
                ),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: data.starships.isNotEmpty
                  && data.vehicles.isNotEmpty
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if(data.vehicles.isNotEmpty)
                  FilledButton(
                    onPressed: onVehiclePressed,
                    child: Text(
                      LocaleKeys.vehicle.tr().toUpperCase(),
                    ),
                  ),
                if(data.starships.isNotEmpty)
                  FilledButton(
                    onPressed: onStarshipPressed,
                    child: Text(
                      LocaleKeys.starship.tr().toUpperCase(),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}