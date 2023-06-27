import 'package:flutter/material.dart';

class ListItemPreviewWidget<T> extends StatelessWidget {
  const ListItemPreviewWidget({
    required this.items,
    this.isEnabled = false,
    this.closeIcon = true,
    this.prefixWidget,
    this.onItemTap,
    this.onWidgetTap,
    super.key,
  });

  final List<T> items;
  final Widget? prefixWidget;
  final bool isEnabled;
  final bool closeIcon;
  final Function(T)? onItemTap;
  final VoidCallback? onWidgetTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: isEnabled ? null : onWidgetTap,
        child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
          if (prefixWidget != null) prefixWidget!,
          ..._buildItems(context)
        ]),
      );
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
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: isEnabled ? Colors.red : Colors.white,
                    ),
              ),
            ),
            if (isEnabled && closeIcon)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                ),
              )
          ],
        ),
      );
}
