import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../common/extract_share_button.dart';
import '../../../../common/leading_widget.dart';
import '../../../../core/helpers/app_interaction_helper.dart';
import '../../application/long_press_provider.dart';

class AppGridItem extends ConsumerWidget {
  const AppGridItem({
    super.key,
    required this.app,
    required this.index,
    required this.tap,
  });

  final Application app;
  final int index;
  final TapCallbacks tap;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final longPress = ref.watch(longPressProvider);
    final selected = ref.watch(selectedItemsProvider).contains(index);

    final textColor = selected ? Theme.of(context).colorScheme.primary : null;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.04),
      child: InkWell(
        onTap: tap.onTap,
        onLongPress: tap.onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8.0),
              LeadingWidget(
                index: index,
                selected: selected,
                packageName: app.packageName,
                size: 50.0,
              ),
              const SizedBox(height: 20.0),
              _GridItemText(
                text: app.appName,
                longPress: longPress,
                textStyle: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: textColor),
              ),
              _GridItemText(
                text: app.packageName,
                longPress: longPress,
                textStyle: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: textColor),
              ),
              const SizedBox(height: 4.0),
              if (!longPress)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () => DeviceApps.openApp(app.packageName),
                      icon: Icon(
                        Symbols.launch,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      onPressed:
                          () => DeviceApps.openAppSettings(app.packageName),
                      icon: Icon(
                        Symbols.info,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    ExtractShareButton(app: app),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridItemText extends StatelessWidget {
  const _GridItemText({
    required this.text,
    required this.longPress,
    required this.textStyle,
  });

  final String text;
  final bool longPress;
  final TextStyle textStyle;

  @override
  Widget build(final BuildContext context) => Text(
    text,
    style: textStyle,
    textAlign: TextAlign.center,
    maxLines: longPress ? 2 : 1,
    overflow: TextOverflow.ellipsis,
  );
}
