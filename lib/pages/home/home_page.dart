import 'package:flutter/material.dart';
import 'package:trip_brain_app/core/helpers/router_config.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page_dependencies.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      onSuggestPlacesTapped: ({required basePlace}) => onSuggestPlacesTapped(
        context: context,
        basePlace: basePlace,
      ),
    );
  }

  void onSuggestPlacesTapped({
    required BuildContext context,
    required String basePlace,
  }) =>
      context.pushQuestionFlow(
        QuestionFlowPageDependencies(
          baseQueryModel: PlaceSuggestionQueryModel.withBasePlace(basePlace),
        ),
      );
}
