import 'package:flutter/material.dart';
import 'package:quizzler/question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Center(
            child: Text(
              "CSQuiz",
            ),
          ),
        ),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int score = 0;

  List<Question> data = [
    Question(
      question: 'The first programming language was Dart',
      answer: false,
    ),
    Question(
      question: 'Python is a compiled programming language',
      answer: false,
    ),
    Question(
      question: 'C++ is a C-like programming language',
      answer: true,
    ),
    Question(
      question: 'In Dart you can only use static type variables',
      answer: false,
    ),
  ];

  int i = 0;

  Icon rightIcon = const Icon(Icons.check, color: Colors.green);
  Icon wrongIcon = const Icon(Icons.close, color: Colors.red);

  _checkAnswer(answer) {
    setState(() {
      if (i < data.length) {
        if (data[i].getAnswer() == answer) {
          scoreKeeper.add(rightIcon);
          score++;
        } else {
          scoreKeeper.add(wrongIcon);
        }
        i++;
      }
      if (i == data.length) {
        _onBasicAlertPressed(
            context, 'Completed', 'Your score is $score/${data.length}');
        scoreKeeper.clear();
        score = 0;
        i = 0;
      }
    });
  }

  _onBasicAlertPressed(context, title, desc) {
    Alert(
      context: context,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          color: Colors.blue[600],
          child: const Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
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
                i == data.length ? '' : data[i].getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blue[900],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colors.blue[600],
                    shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                    height: 50.0,
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      _checkAnswer(true);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    color: Colors.white,
                    shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                    height: 50.0,
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue[600],
                      ),
                    ),
                    onPressed: () {
                      _checkAnswer(false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
