import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/images.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/const/text_style.dart';
import 'package:quizu/screens/quiz/quiz_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String? name;

  @override
  void initState() {
    fecthData();
    super.initState();
  }

  fecthData() async {
    SharedPreferences.getInstance().then((share) {
      setState(() {
        name = share.getString('name');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: purple,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [purple, deepPurple],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              padd16,
              normalText(color: lightgrey, size: 18, text: "Welcome $name"),
              padd10,
              Center(
                child: Lottie.asset(
                  quizanim,
                  height: 200,
                  width: 200,
                ),
              ),
              padd20,
              normalText(color: lightgrey, size: 18, text: "Welcome to our"),
              headingText(color: Colors.white, size: 32, text: "Quiz"),
              const SizedBox(height: 20),
              normalText(
                  color: lightgrey,
                  size: 16,
                  text: "Ready to test your khnowelge and challenge other?"),
              // const Spacer(),

              padd14,
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: size.width - 150,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: headingText(
                        color: purple, size: 18, text: "START QUIZ"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: normalText(
                    color: lightgrey,
                    size: 16,
                    text:
                        "Answer as much questions currectly within 2 minutes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
