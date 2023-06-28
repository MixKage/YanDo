import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({required this.func, super.key});

  final void Function() func;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: func,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              Text(
                AppLocalizations.of(context)!.delete,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
}
