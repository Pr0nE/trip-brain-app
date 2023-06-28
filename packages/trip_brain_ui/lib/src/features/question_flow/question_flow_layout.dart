import 'package:flutter/material.dart';

import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'list_item_preview_widget.dart';
import 'question_answer_widget.dart';

class QuestionFlowLayout extends StatefulWidget {
  const QuestionFlowLayout({
    required this.baseQueryModel,
    required this.onPagePop,
    required this.onQuestionsFinished,
    super.key,
  });

  final PlaceSuggestionQueryModel baseQueryModel;
  final void Function() onPagePop;

  final Function({required PlaceSuggestionQueryModel finishedQueryModel})
      onQuestionsFinished;

  @override
  State<QuestionFlowLayout> createState() => _QuestionFlowLayoutState();
}

class _QuestionFlowLayoutState extends State<QuestionFlowLayout> {
  static const _basePlaceSuggestions = ['bali', 'japan', 'paris'];
  static const _likesSuggestions = ['historical', 'sunny', 'beaches'];
  static const _dislikeSuggestions = ['crowded', 'rainy', 'cold'];

  late QuestionFlowStep _step;
  late PlaceSuggestionQueryModel _queryModel;

  @override
  void initState() {
    _step = QuestionFlowStep.likes;
    _queryModel = widget.baseQueryModel.copyWith();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
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
                  _buildPreviousStepButton(),
                  _buildNextStepButton(),
                ],
              )
            ],
          ),
        ),
      );

  Widget _buildFlowPreview() => Column(
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

  IconButton _buildNextStepButton() => IconButton(
        iconSize: 50,
        onPressed: () {
          switch (_step) {
            case QuestionFlowStep.basePlace:
              setState(() {
                _step = QuestionFlowStep.likes;
              });
              break;
            case QuestionFlowStep.likes:
              setState(() {
                _step = QuestionFlowStep.dislikes;
              });
              break;
            case QuestionFlowStep.dislikes:
              widget.onQuestionsFinished(
                finishedQueryModel: _queryModel.copyWith(),
              );
              // context.pushSuggestions(
              //   SuggestionsPageDependencies(
              //     _queryModel.copyWith(),
              //   ),
              //   replacement: true,
              // );
              break;
          }
        },
        icon: const Icon(Icons.arrow_circle_right_outlined),
      );

  IconButton _buildPreviousStepButton() => IconButton(
        iconSize: 50,
        onPressed: () {
          switch (_step) {
            case QuestionFlowStep.basePlace:
              widget.onPagePop();
              break;
            case QuestionFlowStep.likes:
              setState(() {
                _step = QuestionFlowStep.basePlace;
              });
              break;
            case QuestionFlowStep.dislikes:
              setState(() {
                _step = QuestionFlowStep.likes;
              });
              break;
          }
        },
        icon: const Icon(Icons.arrow_circle_left_outlined),
      );

  Widget _buildBasePlaceStep() => QuestionAnswerWidget(
        question: "ٌWhere do you want to travel?",
        suggestions: _basePlaceSuggestions
            .where((suggestion) => _queryModel.basePlace != suggestion)
            .toList(),
        onAnswer: (place) => _checkNewAnswer(
          currentAnswers: [_queryModel.basePlace],
          newAnswer: place,
          onError: print,
          onChecked: (answer) => setState(
            () => _queryModel = _queryModel.copyWith(basePlace: answer),
          ),
        ),
      );

  Widget _buildDislikesStep() => QuestionAnswerWidget(
        question: "What kind of place you don`t like?",
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
          onError: print,
          onChecked: (answer) => setState(
            () => _queryModel = _queryModel.copyWith(addLike: answer),
          ),
        ),
      );

  void _checkNewAnswer({
    required List<String> currentAnswers,
    required String newAnswer,
    required Function(String) onError,
    required Function(String) onChecked,
  }) {
    final checkedAnswered = newAnswer.trim().toLowerCase();

    if (checkedAnswered.isEmpty) {
      onError('Empty input');
      return;
    }

    if (currentAnswers.contains(checkedAnswered)) {
      onError('Duplicate input');
      return;
    }

    onChecked(checkedAnswered);
  }
}
