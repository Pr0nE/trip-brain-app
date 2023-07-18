import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_brain_app/pages/auth/auth_page.dart';
import 'package:trip_brain_app/pages/details/place_details_page.dart';
import 'package:trip_brain_app/pages/home/home_page.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page_dependencies.dart';
import 'package:trip_brain_app/pages/splash/splash_page.dart';
import 'package:trip_brain_app/pages/suggestions/suggestions_page.dart';
import 'package:trip_brain_app/pages/suggestions/suggestions_page_dependencies.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

const _homePagePath = '/home';
const _splashPagePath = '/splash';
const _authPagePath = '/auth';
const _questionFlowPagePath = 'question-flow';
const _suggestionsPagePath = 'suggestions';
const _detailsPagePath = 'details';

final appRouterConfig = GoRouter(
  routes: [
    GoRoute(
      path: _splashPagePath,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: _authPagePath,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
        path: _homePagePath,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: _questionFlowPagePath,
            builder: (context, state) => QuestionFlowPage(
              //TODO: move depedecies to query parameters
              dependencies: state.extra as QuestionFlowPageDependencies,
            ),
          ),
          GoRoute(
              path: _suggestionsPagePath,
              builder: (context, state) => SuggestionsPage(
                    dependencies: state.extra as SuggestionsPageDependencies,
                  ),
              routes: [
                GoRoute(
                  path: _detailsPagePath,
                  builder: (context, state) => PlaceDetailsPage(
                    place: state.extra as Place,
                  ),
                )
              ]),
        ]),
  ],
  initialLocation: _splashPagePath,
);

extension RouterExtension on BuildContext {
  String get _fullQuestionFlowPagePath =>
      '$_homePagePath/$_questionFlowPagePath';

  String get _fullSuggestionsPagePath => '$_homePagePath/$_suggestionsPagePath';
  String get _fullDetailsPagePath =>
      '$_homePagePath/$_suggestionsPagePath/$_detailsPagePath';

  void goHome<T>() => go(_homePagePath);

  void goAuth<T>() => go(_authPagePath);

  void pushDetails<T>(Place place) => push(_fullDetailsPagePath, extra: place);

  void pushQuestionFlow<T>(QuestionFlowPageDependencies dependencies,
          {bool replacement = false}) =>
      replacement
          ? pushReplacement(_fullQuestionFlowPagePath, extra: dependencies)
          : push(_fullQuestionFlowPagePath, extra: dependencies);

  void pushSuggestions<T>(SuggestionsPageDependencies dependencies,
          {bool replacement = false}) =>
      replacement
          ? pushReplacement(_fullSuggestionsPagePath, extra: dependencies)
          : push(_fullSuggestionsPagePath, extra: dependencies);
}
