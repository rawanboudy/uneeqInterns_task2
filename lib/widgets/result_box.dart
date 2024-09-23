import 'package:flutter/material.dart';
import 'package:quizz_application/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  });

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backround,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0), // Balanced padding
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your Result',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20.0),
          CircleAvatar(
            child: Text(
              '$result/$questionLength',
              style: const TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            radius: 75.0,
            backgroundColor: result == questionLength / 2
                ? Colors.amber // More distinct yellow
                : result < questionLength / 2
                ? incorrect
                : correct,
            foregroundColor: Colors.white,
          ),
          const SizedBox(height: 20.0),
          Text(
            result == questionLength / 2
                ? 'Almost There! Keep Going!'
                : result < questionLength / 2
                ? 'Try Again! You Got This!'
                : 'Great Job! 🎉',
            style: const TextStyle(
              color: neutral,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB4B0E8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 12.0),
              shadowColor: Colors.black.withOpacity(0.3),
              elevation: 5.0,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF918BD5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
              shadowColor: Colors.black.withOpacity(0.3),
              elevation: 5.0,
            ),
            child: const Text(
              'Start Over',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
