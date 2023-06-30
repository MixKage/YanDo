import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Importance {
  low('Низкий'),
  basic('Нет'),
  important('Высокий');

  const Importance(this.lvl);

  final String lvl;

  String getLocalizeName(AppLocalizations locale) {
    switch (this) {
      case Importance.low:
        return locale.low;
      case Importance.basic:
        return locale.basic;
      case Importance.important:
        return locale.important;
    }
  }

  Color getColor(ThemeData themeData) {
    if (this == Importance.important) {
      return Colors.red;
    } else {
      return themeData.secondaryHeaderColor;
    }
  }
}
