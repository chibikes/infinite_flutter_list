
import 'package:equatable/equatable.dart';

class Post extends Equatable {


  final int responseCode;
  final List<Result> results;

  Post({this.responseCode, this.results});

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List; /// this is now of type List<dynamic>
    List<Result> results = list.map((e) => Result.fromJson(e)).toList();
    return Post(responseCode: parsedJson['response_code'], results: results);
  }

  @override
  // TODO: implement props
  List<Object> get props => [responseCode, results]; /// check this does not give you some problems ##################
}

class Result {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Result({this.category, this.type, this.difficulty, this.question, this.correctAnswer, this.incorrectAnswers});
  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    var answersFromJson = parsedJson['incorrect_answers']; /// returns type dynamic
    List<String> incorrectAnswers = answersFromJson.cast<String>();
    return Result(category: parsedJson['category'], type: parsedJson['type'], difficulty: parsedJson['difficulty'], question: parsedJson['question'], correctAnswer: parsedJson['correct_answer'], incorrectAnswers: incorrectAnswers);
  }
}