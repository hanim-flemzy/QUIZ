import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz/pages/quiz_page.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home_page> {

  double wi = 0;
  double he = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Flutter'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          width: MediaQuery.of(context).size.width*0.8,
          height: MediaQuery.of(context).size.height*0.4,
          child: Column(
            children: [
              Image.asset("assets_quizz/cover.jpg",
              width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.2, fit: BoxFit.cover,),

              const Text("Quand un philosophe me répond, je ne comprends plus ma question", style: TextStyle(
                fontStyle: FontStyle.italic, fontSize: 25,
                color: Colors.white, fontWeight: FontWeight.bold,
                ), textAlign: TextAlign.center,
              ),

              SizedBox(height: 20,),

              TextButton(onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (BuildContext context) {
                  return Quiz_Page();
                });
                Navigator.of(context).push(route);
              }, style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
                  child: const Text("Commencer le Quiz", style: TextStyle(
                    fontSize: 20,
                    color: Colors.white, fontWeight: FontWeight.bold,
                  ))
              ),
            ],
          ),
        ),
      ),
    );
  }
}