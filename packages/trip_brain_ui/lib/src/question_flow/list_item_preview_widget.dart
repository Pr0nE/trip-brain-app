import 'package:flutter/material.dart';
import 'package:trip_brain_ui/src/core/theme_helpers.dart';

class ListItemPreviewWidget<T> extends StatelessWidget {
  const ListItemPreviewWidget({
    required this.items,
    required this.prefixTitle,
    this.isEnabled = false,
    this.closeIcon = true,
    this.onItemTap,
    this.onWidgetTap,
    super.key,
  });

  final List<T> items;
  final String prefixTitle;
  final bool isEnabled;
  final bool closeIcon;
  final Function(T)? onItemTap;
  final VoidCallback? onWidgetTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: isEnabled ? null : onWidgetTap,
        child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
          _buildPrefixTitle(context, prefixTitle),
          if (items.isNotEmpty) ..._buildItems(context),
          if (items.isEmpty)
            const TextButton(
              onPressed: null,
              child: Text(''),
            ),
        ]),
      );

  Widget _buildPrefixTitle(BuildContext context, String title) => Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: isEnabled ? FontWeight.bold : FontWeight.normal,
          color: context.onBackground.withOpacity(isEnabled ? 1 : 0.5),
        ),
      );

  List<Widget> _buildItems(BuildContext context) =>
      items.map((item) => _buildItem(context, item)).toList();

  Widget _buildItem(BuildContext context, T item) => Stack(
        children: [
          TextButton(
            onPressed:
                onItemTap != null && isEnabled ? () => onItemTap!(item) : null,
            child: Text(
              item.toString(),
              style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: isEnabled ? FontWeight.bold : FontWeight.normal,
                  color: isEnabled
                      ? context.primaryColor
                      : context.onBackground.withOpacity(0.5)),
            ),
          ),
          if (isEnabled && closeIcon)
            Positioned(
              top: 5,
              right: 5,
              child: IgnorePointer(
                child: Icon(
                  Icons.close,
                  size: 12,
                  color: context.primaryColor,
                ),
              ),
            )
        ],
      );
}
