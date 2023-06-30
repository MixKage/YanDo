import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  const HomeAppBarDelegate({
    required this.doneTasksCount,
    required this.changeVisibility,
    required this.visibility,
  });

  final int doneTasksCount;
  final VoidCallback changeVisibility;
  final bool visibility;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final offset = min(shrinkOffset, maxExtent - minExtent);
    final progress = offset / (maxExtent - minExtent);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: Material(
        elevation: progress < 1 ? 0 : 8,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.lerp(
                  const EdgeInsets.symmetric(horizontal: 44),
                  EdgeInsets.zero,
                  progress,
                )!,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.my_work,
                        style: TextStyle.lerp(
                          Theme.of(context).textTheme.headlineSmall,
                          Theme.of(context).textTheme.titleLarge,
                          progress,
                        ),
                      ),
                      SizedBox(
                        height: 28 * (1 - progress),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: progress < 0.2 ? 1 : 0,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .count_close(doneTasksCount),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: changeVisibility,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      visibility ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 184;

  @override
  double get minExtent => 85;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
