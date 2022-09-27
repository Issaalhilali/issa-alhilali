import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/images.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/const/text_style.dart';
import 'package:quizu/screens/home/home_screen.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  final int? points;
  const ResultScreen({super.key, required this.points});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(18.0),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [purple, deepPurple],
          )),
          child: Column(
            children: [
              padd20,
              padd20,
              Lottie.asset(finish),
              normalText(text: 'you have complete', size: 18, color: lightgrey),
              padd16,
              Text(
                widget.points.toString(),
                style: const TextStyle(color: Colors.amber, fontSize: 25),
              ),
              padd14,
              normalText(text: 'corrent answers!', size: 24, color: lightgrey),
              padd20,
              // I answered X correct answers in QuizU!
              IconButton(
                  onPressed: () {
                    _onShare(context);
                  },
                  icon: const Icon(Icons.share_outlined,
                      color: Colors.white, size: 35)),

              padd20,
              padd20,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.withOpacity(0.8),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: normalText(text: 'Home', size: 18, color: lightgrey),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _onShare(context) async {
    // _onShare method:
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      'My Result Quiz \n I answered ${widget.points} correct answers in QuizU!',
      subject: 'My Quiz',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
