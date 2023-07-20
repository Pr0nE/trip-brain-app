import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/app_helper.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DialogManager(context),
      child: Builder(
        builder: (context) => HomeLayout(
          onSuggestPlacesTapped: (basePlace) => onSuggestPlacesTapped(
            context: context,
            basePlace: basePlace,
          ),
          paymentManager: context.read<PaymentManager>(),
          userFetcher: context.read<AuthCubit>(),
          recentSearchFetcher: context.read<TravelSuggestionRepository>(),
          onRecentSearchTapped: (query) =>
              onRecentSearchTapped(context: context, query: query),
          onLogoutTapped: () {
            context.read<AuthCubit>().logout();
            context.goAuth();
          },
          onBuyBalanceTapped: () => showBuyBalanceBottomSheet(
            context,
            context.read<PaymentManager>(),
          ),
          onError: (error, retryCallback) => checkAppError(
            context: context,
            error: error,
            onRetry: retryCallback,
          ),
        ),
      ),
    );
  }

  void onSuggestPlacesTapped({
    required BuildContext context,
    required String basePlace,
  }) =>
      context.pushQuestionFlow(PlaceSuggestionQuery.withBasePlace(basePlace));

  void onRecentSearchTapped({
    required BuildContext context,
    required PlaceSuggestionQuery query,
  }) =>
      context.pushSuggestions(query);
}
