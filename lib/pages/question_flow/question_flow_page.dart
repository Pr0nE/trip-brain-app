import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_brain_app/core/helpers/router_config.dart';
import 'package:trip_brain_app/pages/suggestions/suggestions_page_dependencies.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

import 'question_flow_page_dependencies.dart';

class QuestionFlowPage extends StatelessWidget {
  const QuestionFlowPage({required this.dependencies, super.key});

  final QuestionFlowPageDependencies dependencies;

  @override
  Widget build(BuildContext context) => QuestionFlowLayout(
        baseQueryModel: dependencies.baseQueryModel,
        onPagePop: context.pop,
        onQuestionsFinished: ({required finishedQueryModel}) =>
            onQuestionsFinished(
          context: context,
          finishedQueryModel: finishedQueryModel,
        ),
      );

  void onQuestionsFinished({
    required BuildContext context,
    required PlaceSuggestionQueryModel finishedQueryModel,
  }) =>
      context.pushSuggestions(
        SuggestionsPageDependencies(queryModel: finishedQueryModel),
      );
}
