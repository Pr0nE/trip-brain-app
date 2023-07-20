import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class QuestionFlowPage extends StatelessWidget {
  const QuestionFlowPage({required this.queryModel, super.key});

  final PlaceSuggestionQueryModel queryModel;

  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => DialogManager(context),
        child: Builder(
          builder: (context) => QuestionFlowLayout(
            baseQueryModel: queryModel,
            onPagePop: context.pop,
            onQuestionsFinished: ({required finishedQueryModel}) =>
                onQuestionsFinished(
              context: context,
              finishedQueryModel: finishedQueryModel,
            ),
          ),
        ),
      );

  void onQuestionsFinished({
    required BuildContext context,
    required PlaceSuggestionQueryModel finishedQueryModel,
  }) =>
      context.pushSuggestions(finishedQueryModel);
}
