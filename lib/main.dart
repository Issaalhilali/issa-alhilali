import 'package:flutter/material.dart';
import 'package:quizu/data/share_const.dart';
import 'package:quizu/screens/home/home_screen.dart';
import 'package:quizu/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final toekn = preferences.getString(ShareConst.shareToekn);
  runApp(MyApp(
    token: toekn,
  ));
}

class MyApp extends StatefulWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget.token == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
