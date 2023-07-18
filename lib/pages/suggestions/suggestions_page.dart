import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/app_helper.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page_dependencies.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

import 'suggestions_page_dependencies.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({required this.dependencies, super.key});

  final SuggestionsPageDependencies dependencies;

  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => DialogManager(context),
        child: Builder(
          builder: (context) => SuggestionsLayout(
            imageFetcher: context.read<TravelSuggestionRepository>(),
            placeSuggester: context.read<TravelSuggestionRepository>(),
            onChangeSuggestionQuery: ({required queryModel}) =>
                onChangeSuggestionQuery(context, queryModel),
            queryModel: dependencies.queryModel,
            onPlaceTapped: (place) => onPlaceTapped(context, place),
            onError: (error, retryCallback) => checkAppError(
              context: context,
              error: error,
              onRetry: retryCallback,
            ),
          ),
        ),
      );

  void onPlaceTapped(BuildContext context, Place place) =>
      context.pushDetails(place);

  void onChangeSuggestionQuery(
    BuildContext context,
    queryModel,
  ) =>
      context.pushQuestionFlow(
        QuestionFlowPageDependencies(baseQueryModel: queryModel),
        replacement: true,
      );
}
