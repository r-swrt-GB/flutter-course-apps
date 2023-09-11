import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  List<Widget> questionButtons = [];
  int correct = 0;
  int incorrect = quizBrain.questionBank.length;
  int questionNumber = quizBrain.questionNumber + 1;

  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer.toUpperCase() == correctAnswer.toUpperCase()) {
        setState(() {
          correct++;
        });
        scoreKeeper.add(Icon(
          Icons.check,
          color: Color.fromARGB(255, 46, 134, 49),
        ));
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
        Alert(
                buttons: [
              DialogButton(
                color: Colors.black,
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
                context: context,
                title: "Incorrect",
                desc: "Correct answer: $correctAnswer")
            .show();
      }
      if (quizBrain.getStatus()) {
        Alert(
                buttons: [
              DialogButton(
                color: Colors.black,
                child: Text(
                  "Finish",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
                context: context,
                title: "Quiz Completed!",
                desc:
                    "Well done on completing the CMPG 122 quiz\nyour final score is: $correct/$incorrect")
            .show();
        correct = 0;
        quizBrain.reset();
        scoreKeeper.clear();
      }
    });
  }

  List<Widget> generateButtons(int amountOfOptions) {
    questionButtons.clear();
    for (int i = 0; i < amountOfOptions; i++) {
      questionButtons.add(Padding(
        padding: EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          child: Text(
            quizBrain.questionBank[quizBrain.questionNumber].questionOptions[i],
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            //The user picked answer.
            checkAnswer(quizBrain
                .questionBank[quizBrain.questionNumber].questionOptions[i]);
            setState(() {
              quizBrain.nextQuestion();
              questionNumber = quizBrain.questionNumber + 1;
            });
          },
        ),
      ));
    }

    return questionButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            "Question $questionNumber",
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
        ),
        Expanded(
            child: Center(
          child: Text(
            "Score: $correct",
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
        )),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: generateButtons(quizBrain
              .questionBank[quizBrain.questionNumber].questionOptions.length),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
