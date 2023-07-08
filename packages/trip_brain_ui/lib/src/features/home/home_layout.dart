import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/features/home/home_layout_cubit.dart';

import 'balance_viewer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    required this.paymentManager,
    required this.userFetcher,
    required this.onSuggestPlacesTapped,
    super.key,
  });

  final PaymentManager paymentManager;
  final UserFetcher userFetcher;
  final void Function({required String basePlace}) onSuggestPlacesTapped;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late final TextEditingController _travelPlaceTextFieldController;
  late final HomeLayoutCubit _cubit;

  String get travelPlace => _travelPlaceTextFieldController.text;

  @override
  void initState() {
    super.initState();

    _cubit = HomeLayoutCubit(
        userFetcher: widget.userFetcher, paymentManager: widget.paymentManager)
      ..onLayoutInit();
    _travelPlaceTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: _cubit,
        builder: (context, state) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
                leading: BalanceViewer(
                  balanceStream: _cubit.balanceStream,
                ),
                actions: [
                  Builder(
                    builder: (context) => TextButton.icon(
                      onPressed: () => onBuyBalanceTapped(context),
                      icon: const Icon(Icons.credit_card),
                      label: const Text('Buy Credit'),
                    ),
                  ),
                ]),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    'I want travel to ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextField(
                    controller: _travelPlaceTextFieldController,
                    style: Theme.of(context).textTheme.headlineMedium,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Beach places',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white38)),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        widget.onSuggestPlacesTapped(basePlace: travelPlace),
                    icon: const Icon(Icons.search),
                    label: const Text('Suggest'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> onBuyBalanceTapped(BuildContext context) async {
    final int? selectedAmount = await _showBalanceSelector(context);
    if (selectedAmount != null) {
      _cubit.onBuyBalance(selectedAmount);
    }
  }

  Future<int?> _showBalanceSelector(BuildContext context) async =>
      showModalBottomSheet<int?>(
        context: context,
        enableDrag: false,
        builder: (context) => BottomSheet(
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(10),
                child: Text('10'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(25),
                child: Text('25'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(50),
                child: Text('50'),
              ),
            ],
          ),
          onClosing: () {},
        ),
      );
}
