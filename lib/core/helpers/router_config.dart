import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_brain_app/pages/auth/auth_page.dart';
import 'package:trip_brain_app/pages/home/home_page.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page.dart';
import 'package:trip_brain_app/pages/question_flow/question_flow_page_dependencies.dart';
import 'package:trip_brain_app/pages/splash/splash_page.dart';
import 'package:trip_brain_app/pages/suggestions/suggestions_page.dart';
import 'package:trip_brain_app/pages/suggestions/suggestions_page_dependencies.dart';

const _homePagePath = '/home';
const _splashPagePath = '/splash';
const _authPagePath = '/auth';
const _questionFlowPagePath = 'question-flow';
const _suggestionsPagePath = 'suggestions';

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
              dependencies: state.extra as QuestionFlowPageDependencies,
            ),
          ),
          GoRoute(
            path: _suggestionsPagePath,
            builder: (context, state) => SuggestionsPage(
              dependencies: state.extra as SuggestionsPageDependencies,
            ),
          ),
        ]),
  ],
  initialLocation: _splashPagePath,
);

extension RouterExtension on BuildContext {
  String get _fullQuestionFlowPagePath =>
      '$_homePagePath/$_questionFlowPagePath';

  String get _fullSuggestionsPagePath => '$_homePagePath/$_suggestionsPagePath';

  void pushHome<T>() => push(_homePagePath);

  void pushAuth<T>() => push(_authPagePath);

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
