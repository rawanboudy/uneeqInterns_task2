import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {

  final baseUrl = 'https://simplequizapp-27085-default-rtdb.firebaseio.com/questions';



  Future<void> addQuestion(String category, Question question) async {
    final url = Uri.parse('$baseUrl/$category/${question
        .id}.json');
    try {
      await http.put(
        url,
        body: json.encode({
          'title': question.title,
          'options': question.options,
        }),
      );
      print('Added question: ${question.title} to $category');
    } catch (error) {
      print('Error adding question: $error');
    }
  }



  // Fetch questions for a specific category
  Future<List<Question>> fetchQuestions(String category) async {
    final url = Uri.parse('$baseUrl/$category.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      var data = json.decode(response.body) as Map<String, dynamic>;

      List<Question> newQuestions = [];
      if (data.isNotEmpty) {
        data.forEach((key, value) {
          if (value is Map<String, dynamic>) {
            var newQuestion = Question(
              id: key,
              title: value['title'],
              options: Map<String, bool>.from(value['options']),
            );
            newQuestions.add(newQuestion);
          }
        });
      }

      return newQuestions;
    } else {
      throw Exception("Failed to load questions for $category");
    }
  }

}
