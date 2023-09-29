class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "What is your Mother`s name?",
    [
      Answer("Ganga", false),
      Answer("Yamuna", false),
      Answer("Saraswati", true),
      Answer("Amantha", false),
    ],
  ));

  list.add(Question(
    "Where are your car keys?",
    [
      Answer("Dining table", true),
      Answer("On table", false),
      Answer("Bed Room", false),
      Answer("Bath Room", false),
    ],
  ));

  list.add(Question(
    "What is your phone password?",
    [
      Answer("123456", false),
      Answer("2808", false),
      Answer("Your name", false),
      Answer("45673", true),
    ],
  ));

  list.add(Question(
    "Did you finished today's task?",
    [
      Answer("Yes", true),
      Answer("No", false),
    ],
  ));

  return list;
}
