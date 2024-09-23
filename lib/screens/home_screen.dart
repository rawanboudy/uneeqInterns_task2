import 'package:flutter/material.dart';
import 'package:quizz_application/constants.dart';
import 'package:quizz_application/models/question_model.dart';
import 'package:quizz_application/widgets/next_button.dart';
import 'package:quizz_application/widgets/option_card.dart';
import 'package:quizz_application/widgets/question_widget.dart';
import 'package:quizz_application/widgets/result_box.dart';
import '../models/db_connect.dart';

class HomeScreen extends StatefulWidget {
  final String category;

  const HomeScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBconnect db = DBconnect();
  late Future<List<Question>> _questions;

  Future<List<Question>> getData() async {

    return await db.fetchQuestions(widget.category);
  }

  @override
  void initState() {
    super.initState();
    _questions = getData();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  int selectedAnswerIndex = -1;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ResultBox(
          result: score,
          questionLength: questionLength,
          onPressed: startOver,
        ),
      );
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
          selectedAnswerIndex = -1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(bool isCorrect, int answerIndex) {
    if (isAlreadySelected) return;

    setState(() {
      selectedAnswerIndex = answerIndex;
      isPressed = true;
      isAlreadySelected = true;
      if (isCorrect) {
        score++;
      }
    });
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _questions,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Questions Available'));
        }

        var extractedData = snapshot.data!;
        return Scaffold(
          backgroundColor: backround,
          appBar: AppBar(
            title: const Text(
              'Quiz App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                letterSpacing: 1.0,
                color: Color(0xFFF7EFE5),
              ),
            ),
            backgroundColor: const Color(0xFFF7EFE5),
            shadowColor: const Color(0xFF674188).withOpacity(0.5),
            elevation: 6.0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF674188), Color(0xFF9D84B7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0BBE4), Color(0xFF957DAD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Score: $score',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              children: [
                QuestionWidget(
                  question: extractedData[index].title,
                  indexAction: index,
                  totalQuestions: extractedData.length,
                ),
                const Divider(color: neutral),
                const SizedBox(height: 25.0),
                for (int i = 0; i < extractedData[index].options.length; i++)
                  GestureDetector(
                    onTap: () => checkAnswerAndUpdate(
                      extractedData[index].options.values.toList()[i],
                      i,
                    ),
                    child: OptionCard(
                      option: extractedData[index].options.keys.toList()[i],
                      color: isPressed
                          ? (extractedData[index].options.values.toList()[i] ? correct : incorrect)
                          : (selectedAnswerIndex == i ? neutral : neutral),
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () => nextQuestion(extractedData.length),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: NextButton(),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
