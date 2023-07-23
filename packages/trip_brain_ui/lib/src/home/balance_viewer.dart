import 'package:flutter/material.dart';

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
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).colorScheme.primary),
              );
            }

            return _buildBuySuggestionsButton();
          }

          return const SizedBox(width: 100, child: LinearProgressIndicator());
        },
      );

  Widget _buildBuySuggestionsButton() => TextButton.icon(
        onPressed: onBuySuggestionTapped,
        icon: const Icon(Icons.add),
        label: const Text('Get more suggestions'),
      );
}
