import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/screens/login/login_screen.dart';
import 'package:quizu/screens/widgets/profile.dart';
import 'package:quizu/screens/widgets/quiz.dart';
import 'package:quizu/screens/widgets/topscore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  String? toekn;

  @override
  void initState() {
    sharedata();
    tabbar();

    super.initState();
  }

  tabbar() {
    return _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  sharedata() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        toekn = value.getString("token");
      });
    });
  }

  logout() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        value.remove('token').whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Home", "Top Scores", "Profile"],
        icons: const [
          UniconsLine.home,
          UniconsLine.gold,
          UniconsLine.user_circle
        ],

        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: lightgrey,
          fontWeight: FontWeight.bold,
          fontFamily: "quick_semi",
        ),
        tabIconColor: Colors.yellow,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.deepPurple[400],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.deepPurple,

        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics:
            const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const QuizApp(),
          const TopScore(),
          const Profile(),
        ],
      ),
    );
  }
}
