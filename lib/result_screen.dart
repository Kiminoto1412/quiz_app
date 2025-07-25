import 'package:flutter/material.dart';
import 'package:quiz_app/data/question.dart';
import 'package:quiz_app/question_summary.dart';

class ResultScreen extends StatelessWidget {
  final List<String> selectedAnswers;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.selectedAnswers,
    required this.onRestart,
  });

  int get correctAnswers {
    int correctAnswers = 0;
    for (var i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == questions[i].answers[0]) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correctAnswer': questions[i].answers[0],
        'userAnswer': selectedAnswers[i],
      });
    }
    return summary;
  }

  // void restartQuiz() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const Quiz()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = questions.length;
    final correctAnswers = this.correctAnswers;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $correctAnswers out of $totalQuestions questions correctly!',
            ),
            SizedBox(height: 30),
            Text('List of answers and questions...:'),
            QuestionSummary(summaryData: getSummaryData()),
            SizedBox(height: 30),
            TextButton(
              onPressed: onRestart,
              child: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
