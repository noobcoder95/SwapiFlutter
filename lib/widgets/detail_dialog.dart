import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swapi_flutter/data/models/home_world.dart';
import 'package:swapi_flutter/data/models/starship.dart';
import 'package:swapi_flutter/data/models/vehicle.dart';
import 'package:swapi_flutter/localizations/locale_keys.g.dart';
import 'package:swapi_flutter/utils/extension/string.dart';

class DetailDialog extends StatelessWidget {
  final Object data;
  const DetailDialog({super.key, required this.data});

  static show({
    required BuildContext context,
    required Object data}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DetailDialog(data: data);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String title;
    Widget content;

    if(data is Starship) {
      final starship = data as Starship;
      title = starship.name;
      content = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${LocaleKeys.model.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            starship.model.replaceIfEmpty,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '${LocaleKeys.strarshipClass.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            starship.starshipClass.replaceIfEmpty,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '${LocaleKeys.hyperdriveRating.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            starship.hyperdriveRating.replaceIfEmpty,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '${LocaleKeys.costInCredits.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            starship.costInCredits.replaceIfEmpty,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '${LocaleKeys.manufacturer.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            starship.manufacturer.replaceIfEmpty,
            textAlign: TextAlign.center,
          )
        ],
      );
    } else if(data is Vehicle) {
      final vehicle = data as Vehicle;
      title = vehicle.name;
      content = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${LocaleKeys.model.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            vehicle.model.replaceIfEmpty,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '${LocaleKeys.costInCredits.tr()}:',
            style: theme.textTheme.titleSmall,
          ),
          Text(
            vehicle.costInCredits.replaceIfEmpty,
            textAlign: TextAlign.center,
          )
        ],
      );
    } else {
      final homeworld = data as HomeWorld;
      title = homeworld.name;
      content = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.population.tr(),
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 5),
              Text(
                LocaleKeys.climate.tr(),
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(2, (index) => Padding(
              padding: index == 2
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(bottom: 5),
              child: const Text('  : '),
            )),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(homeworld.population.replaceIfEmpty),
                const SizedBox(height: 5),
                Text(homeworld.climate.replaceIfEmpty)
              ],
            ),
          )
        ],
      );
    }

    return AlertDialog(
      title: Text(
        title.replaceIfEmpty,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 10
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: ()=> Navigator.of(context).pop(),
          child: Text(LocaleKeys.close.tr()),
        )
      ],
    );
  }
}