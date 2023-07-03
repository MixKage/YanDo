import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFieldTaskPage extends StatelessWidget {
  const TextFieldTaskPage({
    required this.textController,
    super.key,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) => Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: TextField(
          controller: textController,
          minLines: 4,
          maxLines: 100,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.create_task_from_textField,
          ),
        ),
      );
}
