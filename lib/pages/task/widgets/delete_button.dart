import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yando/theme/theme.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({required this.func, super.key});

  final VoidCallback func;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: func,
        borderRadius:
            Theme.of(context).extension<MyExtension>()!.normalBorderRadius,
        child: Padding(
          padding: Theme.of(context).extension<MyExtension>()!.normalEdgeInsets,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Theme.of(context).extension<MyExtension>()!.error,
              ),
              Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(
                  color: Theme.of(context).extension<MyExtension>()!.error,
                ),
              ),
            ],
          ),
        ),
      );
}
