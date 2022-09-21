import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:quizu/data/share_const.dart';
import 'package:quizu/screens/login/login_screen.dart';
import 'package:quizu/screens/widgets/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
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
      initialIndex: 1,
      length: 4,
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
      appBar: AppBar(
          // title: Text(widget.title!),
          ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Dashboard", "Home", "Profile", "Settings"],
        icons: const [
          Icons.dashboard,
          Icons.home,
          Icons.people_alt,
          Icons.settings
        ],

        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,

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
          const Center(
            child: Text("Dashboard"),
          ),
          const Center(
            child: Text("Home"),
          ),
          const Profile(),
          const Center(
            child: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
