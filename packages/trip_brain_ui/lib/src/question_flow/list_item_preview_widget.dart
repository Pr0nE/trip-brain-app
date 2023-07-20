import 'package:flutter/material.dart';

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
          ..._buildItems(context)
        ]),
      );

  Widget _buildPrefixTitle(BuildContext context, String title) => Text(title);
  List<Widget> _buildItems(BuildContext context) =>
      items.map((item) => _buildItem(context, item)).toList();

  Widget _buildItem(BuildContext context, T item) => TextButton(
        onPressed:
            onItemTap != null && isEnabled ? () => onItemTap!(item) : null,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: isEnabled ? 30 : 12),
              ),
            ),
            if (isEnabled && closeIcon)
              Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.close_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
          ],
        ),
      );
}
