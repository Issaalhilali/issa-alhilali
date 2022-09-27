import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/data/share_const.dart';
import 'package:quizu/repository/api_services.dart';
import 'package:quizu/repository/auth/auth.dart';
import 'package:quizu/repository/sql/sql_score.dart';
import 'package:quizu/screens/home/home_screen.dart';
import 'package:quizu/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final toekn = preferences.getString(ShareConst.shareToekn);
  SqliteService.initializeDB();
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Repository(),
        ),
        RepositoryProvider(
          create: (context) => APIService(),
        ),
      ],
      child: MaterialApp(
        title: 'QuizU',
        color: deepPurple,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: widget.token == null ? const LoginScreen() : const HomeScreen(),
      ),
    );
  }
}
