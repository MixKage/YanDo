import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yando/theme/theme.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    required this.selectData,
    required this.offData,
    required this.dateTime,
    super.key,
  });

  final Future<DateTime> Function() selectData;
  final void Function() offData;
  final DateTime? dateTime;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  bool dateTimeOn = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    dateTimeOn = widget.dateTime != null;
    selectedDate = widget.dateTime ?? DateTime.now();
    super.initState();
  }

  String getMonth({required int index}) {
    switch (index) {
      case 1:
        return AppLocalizations.of(context)!.january;
      case 2:
        return AppLocalizations.of(context)!.february;
      case 3:
        return AppLocalizations.of(context)!.march;
      case 4:
        return AppLocalizations.of(context)!.april;
      case 5:
        return AppLocalizations.of(context)!.may;
      case 6:
        return AppLocalizations.of(context)!.june;
      case 7:
        return AppLocalizations.of(context)!.july;
      case 8:
        return AppLocalizations.of(context)!.august;
      case 9:
        return AppLocalizations.of(context)!.september;
      case 10:
        return AppLocalizations.of(context)!.october;
      case 11:
        return AppLocalizations.of(context)!.november;
      case 12:
        return AppLocalizations.of(context)!.december;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.deadline,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (dateTimeOn)
                InkWell(
                  onTap: () async {
                    selectedDate = await widget.selectData();
                    setState(() {});
                  },
                  borderRadius: Theme.of(context)
                      .extension<MyExtension>()!
                      .normalBorderRadius,
                  child: Text(
                    '${selectedDate.day} '
                    '${getMonth(index: selectedDate.month)}'
                    ' ${selectedDate.year}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                )
              else
                const SizedBox(height: 18),
            ],
          ),
          Switch(
            value: dateTimeOn,
            onChanged: (value) {
              widget.offData();
              dateTimeOn = value;
              setState(() {});
            },
          ),
        ],
      );
}
