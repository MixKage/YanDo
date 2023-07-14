import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yando/theme/theme.dart';

class AppBarTaskPage extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTaskPage({
    required this.unsaveExit,
    required this.saveTask,
    super.key,
  });

  final VoidCallback unsaveExit;
  final VoidCallback saveTask;

  @override
  Widget build(BuildContext context) => AppBar(
        elevation: 0,
        leading: Material(
          color: Theme.of(context).extension<MyExtension>()!.transparent,
          child: InkWell(
            onTap: unsaveExit,
            borderRadius:
                Theme.of(context).extension<MyExtension>()!.normalBorderRadius,
            child: Padding(
              padding:
                  Theme.of(context).extension<MyExtension>()!.normalEdgeInsets,
              child: Icon(
                Icons.clear,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.black12),
              ),
              onPressed: saveTask,
              child: Text(
                AppLocalizations.of(context)!.save,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          )
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
