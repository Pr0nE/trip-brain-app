import 'package:flutter/material.dart';
import 'package:trip_brain_ui/src/core/theme_helpers.dart';

class BalanceViewer extends StatelessWidget {
  const BalanceViewer({
    required this.balanceStream,
    required this.onBuySuggestionTapped,
    super.key,
  });

  final Stream<int> balanceStream;
  final VoidCallback onBuySuggestionTapped;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: balanceStream,
        builder: (context, snap) {
          if (snap.hasData) {
            final balance = snap.data!;

            if (balance > 0) {
              return Text(
                'You have $balance suggestions left',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.primaryColor),
              );
            }

            return _buildBuySuggestionsButton(context);
          }

          return const SizedBox(width: 100, child: LinearProgressIndicator());
        },
      );

  Widget _buildBuySuggestionsButton(BuildContext context) => TextButton.icon(
        onPressed: onBuySuggestionTapped,
        icon: const Icon(Icons.add),
        label: Text(
          'Get more suggestions',
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.primaryColor),
        ),
      );
}
