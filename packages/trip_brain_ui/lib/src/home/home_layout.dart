import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/home/home_layout_cubit.dart';
import 'package:trip_brain_ui/src/home/recent_search_list.dart';

import 'balance_viewer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    required this.paymentManager,
    required this.userFetcher,
    required this.recentSearchFetcher,
    required this.onSuggestPlacesTapped,
    required this.onRecentSearchTapped,
    required this.onLogoutTapped,
    required this.onBuyBalanceTapped,
    required this.onError,
    super.key,
  });

  final PaymentManager paymentManager;
  final UserFetcher userFetcher;
  final RecentSuggestionsFetcher recentSearchFetcher;
  final void Function(String basePlace) onSuggestPlacesTapped;
  final VoidCallback onLogoutTapped;
  final VoidCallback onBuyBalanceTapped;
  final void Function(PlaceSuggestionQuery query) onRecentSearchTapped;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late final TextEditingController _travelPlaceTextFieldController;
  late final HomeLayoutCubit _cubit;

  String get travelPlace => _travelPlaceTextFieldController.text.toLowerCase();

  @override
  void initState() {
    super.initState();

    _cubit = HomeLayoutCubit(
        userFetcher: widget.userFetcher, paymentManager: widget.paymentManager)
      ..onLayoutInit();
    _travelPlaceTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<HomeLayoutCubit, HomeLayoutState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is HomeLayoutErrorState) {
            widget.onError(state.error, state.retryCallback);
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                leading: Center(
                  child: BalanceViewer(
                    balanceStream: _cubit.balanceStream,
                  ),
                ),
                actions: [
                  Builder(
                    builder: (context) => TextButton.icon(
                      onPressed: widget.onBuyBalanceTapped,
                      icon: const Icon(Icons.credit_card),
                      label: const Text('Buy Credit'),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: widget.onLogoutTapped,
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
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
                    onPressed: () => widget.onSuggestPlacesTapped(travelPlace),
                    icon: const Icon(Icons.search),
                    label: const Text('Suggest'),
                  ),
                  Expanded(
                    child: RecentSearchList(
                      fetcher: widget.recentSearchFetcher,
                      onRecentSearchTapped: widget.onRecentSearchTapped,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _cubit.close();

    super.dispose();
  }
}
