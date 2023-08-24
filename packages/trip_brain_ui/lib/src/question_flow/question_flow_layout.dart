import 'package:flutter/material.dart';

import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/theme_helpers.dart';

import 'list_item_preview_widget.dart';
import 'question_answer_widget.dart';

class QuestionFlowLayout extends StatefulWidget {
  const QuestionFlowLayout({
    required this.baseQueryModel,
    required this.onPagePop,
    required this.onQuestionsFinished,
    super.key,
  });

  final PlaceSuggestionQuery baseQueryModel;
  final void Function() onPagePop;

  final void Function({required PlaceSuggestionQuery finishedQueryModel})
      onQuestionsFinished;

  @override
  State<QuestionFlowLayout> createState() => _QuestionFlowLayoutState();
}

class _QuestionFlowLayoutState extends State<QuestionFlowLayout> {
  static const _basePlaceSuggestions = ['bali', 'france', 'africa', 'anywhere'];
  static const _likesSuggestions = ['historical', 'sunny', 'beaches'];
  static const _dislikeSuggestions = ['crowded', 'rainy', 'cold'];

  late QuestionFlowStep _step;
  late PlaceSuggestionQuery _queryModel;

  @override
  void initState() {
    _step = widget.baseQueryModel.basePlace.isEmpty
        ? QuestionFlowStep.basePlace
        : QuestionFlowStep.likes;
    _queryModel = widget.baseQueryModel.copyWith();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          switch (_step) {
            case QuestionFlowStep.basePlace:
              return Future.value(true);
            case QuestionFlowStep.likes:
              setState(() => _step = QuestionFlowStep.basePlace);
              return Future.value(false);
            case QuestionFlowStep.dislikes:
              setState(() => _step = QuestionFlowStep.likes);
              return Future.value(false);
          }
        },
        child: SafeArea(
          child: Scaffold(
            // TODO buttons should be float
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Container(
                  color: Colors.black12,
                  child: Center(
                    child: _buildFlowPreview(),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: switch (_step) {
                    QuestionFlowStep.basePlace => _buildBasePlaceStep(),
                    QuestionFlowStep.likes => _buildLikesStep(),
                    QuestionFlowStep.dislikes => _buildDislikesStep(),
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildPreviousStepButton()),
                    Expanded(child: _buildNextStepButton()),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildFlowPreview() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListItemPreviewWidget<String>(
            items: [_queryModel.basePlace],
            prefixTitle: 'I want travel to ',
            isEnabled: _step == QuestionFlowStep.basePlace,
            closeIcon: false,
            onWidgetTap: () =>
                setState(() => _step = QuestionFlowStep.basePlace),
          ),
          ListItemPreviewWidget<String>(
            items: _queryModel.likes,
            isEnabled: _step == QuestionFlowStep.likes,
            prefixTitle: 'I like ',
            onItemTap: (item) => setState(
                () => _queryModel = _queryModel.copyWith(removeLike: item)),
            onWidgetTap: () => setState(() => _step = QuestionFlowStep.likes),
          ),
          ListItemPreviewWidget<String>(
            items: _queryModel.dislikes,
            isEnabled: _step == QuestionFlowStep.dislikes,
            prefixTitle: 'I dislike ',
            onItemTap: (item) => setState(
                () => _queryModel = _queryModel.copyWith(removeDislike: item)),
            onWidgetTap: () =>
                setState(() => _step = QuestionFlowStep.dislikes),
          ),
        ],
      );

  Widget _buildNextStepButton() => Directionality(
        textDirection: TextDirection.rtl,
        child: TextButton.icon(
          label: Text(
            switch (_step) {
              QuestionFlowStep.basePlace => 'Next Step',
              QuestionFlowStep.likes => 'Next Step',
              QuestionFlowStep.dislikes => 'Suggest',
            },
            style: context.textTheme.titleLarge,
          ),
          onPressed: switch (_step) {
            QuestionFlowStep.basePlace => () =>
                setState(() => _step = QuestionFlowStep.likes),
            QuestionFlowStep.likes => () =>
                setState(() => _step = QuestionFlowStep.dislikes),
            QuestionFlowStep.dislikes => () => widget.onQuestionsFinished(
                  finishedQueryModel: _queryModel.copyWith(),
                ),
          },
          icon: const Icon(
            Icons.arrow_circle_right_outlined,
            size: 45,
          ),
        ),
      );
  Widget _buildPreviousStepButton() => TextButton.icon(
        label: Text(
          switch (_step) {
            QuestionFlowStep.basePlace => 'Back to home',
            QuestionFlowStep.likes => 'Previous Step',
            QuestionFlowStep.dislikes => 'Previous Step',
          },
          style: context.textTheme.titleLarge,
        ),
        onPressed: switch (_step) {
          QuestionFlowStep.basePlace => widget.onPagePop,
          QuestionFlowStep.likes => () =>
              setState(() => _step = QuestionFlowStep.basePlace),
          QuestionFlowStep.dislikes => () =>
              setState(() => _step = QuestionFlowStep.likes),
        },
        icon: const Icon(
          Icons.arrow_circle_left_outlined,
          size: 45,
        ),
      );

  Widget _buildBasePlaceStep() => QuestionAnswerWidget(
        question: "Where do you want to travel?",
        suggestions: _basePlaceSuggestions
            .where((suggestion) => _queryModel.basePlace != suggestion)
            .toList(),
        onAnswer: (place) => _checkNewAnswer(
          currentAnswers: [_queryModel.basePlace],
          newAnswer: place,
          onError: print,
          onChecked: (answer) => setState(
            () {
              _queryModel = _queryModel.copyWith(basePlace: answer);
              _step = QuestionFlowStep.likes;
            },
          ),
        ),
      );

  Widget _buildDislikesStep() => QuestionAnswerWidget(
        question: "What kind of place you don't like?",
        suggestions: _dislikeSuggestions
            .where(
              (suggestion) => !_queryModel.dislikes.contains(suggestion),
            )
            .toList(),
        onAnswer: (dislike) => _checkNewAnswer(
          currentAnswers: _queryModel.dislikes,
          newAnswer: dislike,
          onError: print,
          onChecked: (answer) => setState(
            () => _queryModel = _queryModel.copyWith(addDislike: answer),
          ),
        ),
      );

  Widget _buildLikesStep() => QuestionAnswerWidget(
        question: 'What kind of place you like more?',
        suggestions: _likesSuggestions
            .where(
              (suggestion) => !_queryModel.likes.contains(suggestion),
            )
            .toList(),
        onAnswer: (like) => _checkNewAnswer(
          currentAnswers: _queryModel.likes,
          newAnswer: like,
          onChecked: (answer) => setState(
            () => _queryModel = _queryModel.copyWith(addLike: answer),
          ),
        ),
      );

  void _checkNewAnswer({
    required List<String> currentAnswers,
    required String newAnswer,
    void Function(String)? onError,
    required void Function(String) onChecked,
  }) {
    final checkedAnswered = newAnswer.trim().toLowerCase();

    if (checkedAnswered.isEmpty) {
      onError?.call('Empty input');
      return;
    }

    if (currentAnswers.contains(checkedAnswered)) {
      onError?.call('Duplicate input');
      return;
    }

    if (newAnswer.length > 20) {
      onError?.call('input is too long');
      return;
    }
    if (currentAnswers.length > 5) {
      onError?.call('Max number of input is 5');
      return;
    }

    onChecked(checkedAnswered);
  }
}
