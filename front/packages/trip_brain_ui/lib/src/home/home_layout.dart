import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/theme_helpers.dart';
import 'package:trip_brain_ui/src/home/home_layout_cubit.dart';
import 'package:trip_brain_ui/src/home/recent_search_list.dart';
import 'package:trip_brain_ui/src/localization/localization_extensions.dart';

import 'balance_viewer.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    required this.paymentManager,
    required this.userFetcher,
    required this.recentSearchFetcher,
    required this.onSuggestPlacesTapped,
    required this.onRecentSearchTapped,
    required this.onLogoutTapped,
    required this.onBuySuggestionTapped,
    required this.onError,
    super.key,
  });

  final PaymentManager paymentManager;
  final UserFetcher userFetcher;
  final RecentSuggestionsFetcher recentSearchFetcher;
  final void Function(String basePlace) onSuggestPlacesTapped;
  final VoidCallback onLogoutTapped;
  final VoidCallback onBuySuggestionTapped;
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
                elevation: 3,
                centerTitle: false,
                title: BalanceViewer(
                  balanceStream: _cubit.balanceStream,
                  onBuySuggestionTapped: widget.onBuySuggestionTapped,
                ),
                actions: [
                  BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                    bloc: _cubit,
                    buildWhen: (previous, current) =>
                        current is HomeLayoutUserLoadedState,
                    builder: (context, state) => TextButton.icon(
                      onPressed: widget.onLogoutTapped,
                      icon: const Icon(Icons.logout),
                      label: Text(
                        'Logout ${getUsername(state.getUser, context)}',
                        style: context.textTheme.bodyLarge
                            ?.copyWith(color: context.primaryColor),
                      ),
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
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: context.onBackground),
                  ),
                  TextField(
                    key: const Key('travelToTextField'),
                    controller: _travelPlaceTextFieldController,
                    style: context.textTheme.headlineMedium,
                    onSubmitted: (_) =>
                        widget.onSuggestPlacesTapped(travelPlace),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Here...',
                      hintStyle: context.textTheme.headlineMedium?.copyWith(
                          color: context.onBackground.withOpacity(0.3)),
                    ),
                  ),
                  Center(
                    child: TextButton.icon(
                      onPressed: () =>
                          widget.onSuggestPlacesTapped(travelPlace),
                      icon: const Icon(
                        Icons.travel_explore,
                        size: 30,
                      ),
                      label: Text(
                        'Suggest',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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

  String getUsername(User? user, BuildContext context) {
    if (user == null) {
      return '';
    }

    if (user.isGuest) {
      return context.localization.guest;
    }

    return user.name;
  }

  @override
  void dispose() {
    _cubit.close();

    super.dispose();
  }
}
