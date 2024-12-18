import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz/models/appdatas.dart';
import 'package:my_quiz/models/questions.dart';

class Quiz_Page extends StatefulWidget {
  const Quiz_Page({super.key});
  @override
  State<StatefulWidget> createState() {
    return Quiz_State();
  }
}

class Quiz_State extends State<Quiz_Page> {
  int score = 0;
  int index = 0;
  final List<Question> questions = AppDatas().listeQuestions;
  
  void _AnswersQ() {
    showModalBottomSheet(context: context,
        builder: (BuildContext context){
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.all(16),
            child: Text("Ma réponse est:",
            style: Theme.of(context).textTheme.titleMedium,),
            ),
            answerRow("C'est vrai", Icons.check, Colors.green, true),
            answerRow("C'est faux", Icons.cancel_outlined, Colors.red, false),
            answerRow("Je ne sais pas", Icons.question_mark, Colors.grey, null)
          ],
        ),
      );
        });
  }

  InkWell answerRow(String text, IconData iconDat, Color color, bool ?isTrue) {
    return InkWell(
      onTap: (){
        _checkAnswer(isTrue);
      },
      child: Padding(padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconDat, color: color,),
          const SizedBox(width: 30,),
          Text(text),
        ],
      ),)
    );
  }

  void _checkAnswer(bool? isTrue) {
    Navigator.pop(context);
    if (isTrue == null) {
      return;
    }
    final quest = questions[index];
    final answer = quest.reponse;
    final myanswer = isTrue == answer;
    if (myanswer == true) {
      setState(() {
        score++;
      });
    }
    _showAnswer(myanswer, quest);
  }

  void _showAnswer(bool isSuccess, Question q) {
    String title = (isSuccess) ? "C'est gagné" :"Raté";
    String img = (isSuccess) ? 'vrai.jpg': 'faux.jpg';
    String imageurl = "assets_quizz/$img";
    showDialog(context: context,
        barrierDismissible: false,
        builder:  (BuildContext ctx) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imageurl),
            Text(q.explication)
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
            toNextQuestion();
          },
              child: Text("Ok"))
        ],
      );
        });
  }

  void toNextQuestion(){
    if (index < questions.length - 1) {
      setState(() {
        index ++;
      });
    } else {
      finalPopup();
    }
  }

  void finalPopup() {
    showDialog(context: context,
        barrierDismissible: false,
        builder:  (BuildContext ctx) {
          return AlertDialog(
            title: const Text("C'est la fin du quiz"),
            content: Text("Votre score est de:$score points"),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
                  child: Text("Ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Question q = questions[index];
    return Scaffold(
      appBar: AppBar(
        title: Text("Score: $score"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Question n°: ${index + 1} / ${questions.length}",style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal),),
            Question_Card(img_path: q.imagePath, question: q.question),
            OutlinedButton(onPressed: _AnswersQ,
                child: const Text("Je réponds"))
          ],
        ),
      ),
    );
  }

  Container Question_Card({required String img_path, required String question}) {
    double size = MediaQuery.of(context).size.width*0.9;
    TextStyle descrip = const TextStyle(
      fontStyle: FontStyle.italic,
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    );
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      width: size,
      height: size,
      child: Column(
        children: [
          Image.asset("assets_quizz/$img_path",
            height: size * 0.85,
            width: size,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20,),
          Text(question, style: descrip, textAlign: TextAlign.center,),

        ],
      ),
    );
  }
}