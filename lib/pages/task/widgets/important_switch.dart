import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yando/model/importance.dart';
import 'package:yando/model/task.dart';

class ImportantComboBox extends StatelessWidget {
  const ImportantComboBox({
    required this.selectedType,
    required this.task,
    required this.onChanged,
    super.key,
  });

  final Importance selectedType;
  final TaskModel task;
  final void Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.lvl,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          DropdownButton<Importance>(
            iconSize: 0,
            underline: const SizedBox(),
            value: selectedType,
            items: Importance.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.getLocalizeName(
                          AppLocalizations.of(context)!,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: e.getColor(Theme.of(context)),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      );
}
