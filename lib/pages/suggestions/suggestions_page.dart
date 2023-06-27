import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/router_config.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page_dependencies.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

import 'suggestions_page_dependencies.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({required this.dependencies, super.key});

  final SuggestionsPageDependencies dependencies;

  @override
  Widget build(BuildContext context) => SuggestionsLayout(
        imageFetcher: context.read<TravelSuggestionRepository>(),
        placeSuggester: context.read<TravelSuggestionRepository>(),
        onChangeSuggestionQuery: ({required queryModel}) =>
            onChangeSuggestionQuery(context: context, queryModel: queryModel),
        queryModel: dependencies.queryModel,
      );

  void onChangeSuggestionQuery({
    required BuildContext context,
    required queryModel,
  }) =>
      context.pushQuestionFlow(
        QuestionFlowPageDependencies(baseQueryModel: queryModel),
        replacement: true,
      );
}
