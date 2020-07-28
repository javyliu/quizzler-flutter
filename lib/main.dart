import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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
  List<Icon> scoreKeeper;
  List<Map<String, dynamic>> questions;
  Iterator questionIterate;
  var currentQuestion;
  final Icon iconOk = Icon(
    Icons.check,
    color: Colors.green,
  );
  final Icon iconFault = Icon(
    Icons.close,
    color: Colors.red,
  );

  List<Question> questionBank = [
    Question("You can lead a cow down stairs but not up stairs.", false),
    Question("Approximately one quarter of human bones are in the feet.", true),
    Question("A slug\'s blood is green.", true),
  ];

  _QuizPageState() {
    print("重新初始化");
    scoreKeeper = [];
//    questions = [
//      {
//        'question': 'You can lead a cow down stairs but not up stairs.',
//        'answer': false
//      },
//      {
//        'question': 'Approximately one quarter of human bones are in the feet.',
//        'answer': true
//      },
//      {'question': 'A slug\'s blood is green.', 'answer': true},
//    ];
    questionIterate = questionBank.iterator;
    questionIterate.moveNext();
  }




  @override
  Widget build(BuildContext context) {
    currentQuestion = questionIterate.current;
    print("重新build---$currentQuestion -");
    currentQuestion ??= Question("恭喜，您已完成所有问答！",  null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                currentQuestion.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                var icon;
                if (currentQuestion.answer == null) return;
                icon = currentQuestion.answer == true ? iconOk : iconFault;
                questionIterate.moveNext();

                setState(() {
                  scoreKeeper.add(icon);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                var icon;
                if (currentQuestion.answer == null) return;
                icon = currentQuestion.answer == true ? iconFault : iconOk;
                questionIterate.moveNext();

                setState(() {
                  scoreKeeper.add(icon);
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
