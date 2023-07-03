import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarTaskPage extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTaskPage({
    required this.unsaveExit,
    required this.saveTask,
    super.key,
  });

  final void Function() unsaveExit;
  final void Function() saveTask;

  @override
  Widget build(BuildContext context) => AppBar(
        elevation: 0,
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: unsaveExit,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
