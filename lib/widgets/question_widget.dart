import 'package:flutter/material.dart';
import 'package:quizz_application/constants.dart'; // Assuming 'neutral' is defined here

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.indexAction,
    required this.totalQuestions,
  });

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0), // Increased padding for a more spacious feel
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFC8A1E0).withOpacity(0.8),
            Color(0xFF9D84B7).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'Question ${indexAction + 1} of $totalQuestions: $question',
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF7EFE5),
          letterSpacing: 0.8,
          height: 1.5,
        ),
      ),
    );
  }
}
