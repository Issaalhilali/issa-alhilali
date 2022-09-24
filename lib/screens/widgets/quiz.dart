import 'package:flutter/material.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/images.dart';
import 'package:quizu/const/text_style.dart';
import 'package:quizu/screens/quiz/quiz_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: purple,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [purple, deepPurple],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                balloon2,
              ),
              const SizedBox(height: 20),
              normalText(color: lightgrey, size: 18, text: "Welcome to our"),
              headingText(color: Colors.white, size: 32, text: "Quiz App"),
              const SizedBox(height: 20),
              normalText(
                  color: lightgrey,
                  size: 16,
                  text:
                      "Do you feel confident? Here you'll face our most difficult questions!"),
              const Spacer(),
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
                    width: size.width - 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        headingText(color: purple, size: 18, text: "Continue"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
