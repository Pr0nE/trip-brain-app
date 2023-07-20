import 'package:flutter/material.dart';

class QuestionAnswerWidget extends StatefulWidget {
  const QuestionAnswerWidget({
    required this.question,
    required this.suggestions,
    required this.onAnswer,
    super.key,
  });
  final String question;
  final List<String> suggestions;
  final Function(String) onAnswer;

  @override
  State<QuestionAnswerWidget> createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  late final TextEditingController _answerTextfieldController;

  @override
  void initState() {
    _answerTextfieldController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Question
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.question,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            // Input field
            TextField(
              decoration: InputDecoration(hintText: 'Your answer...'),
              controller: _answerTextfieldController,
              onSubmitted: (value) {
                widget.onAnswer(value);
                _answerTextfieldController.clear();
              },
            ),
            // Suggestions
            Row(
              children: widget.suggestions
                  .map(
                    (String suggestion) => TextButton(
                      onPressed: () => widget.onAnswer(suggestion),
                      child: Text(suggestion),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      );
}
