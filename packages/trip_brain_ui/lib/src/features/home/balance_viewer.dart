import 'package:flutter/widgets.dart';

class BalanceViewer extends StatelessWidget {
  const BalanceViewer({required this.balanceStream, super.key});

  final Stream<int> balanceStream;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: balanceStream,
        builder: (context, snap) {
          final balance = getBalance(snap);

          return Text(balance);
        },
      );

  String getBalance(AsyncSnapshot<int> snap) =>
      snap.hasData ? snap.data!.toString() : '0';
}
