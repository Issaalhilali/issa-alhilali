import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/bloc/info/info_bloc.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/images.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/const/text_style.dart';

import 'package:quizu/models/info_model.dart';
import 'package:quizu/models/myscore.dart';
import 'package:quizu/repository/auth/auth.dart';
import 'package:quizu/repository/sql/sql_score.dart';
import 'package:quizu/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? token;

  @override
  void initState() {
    sharedata();

    super.initState();
  }

  List<MyScore> sco = [];
  // void _refreshNotes() async {
  //   final data = await SqliteService.getItems();
  //   setState(() {
  //     sco = data;
  //   });
  // }

  SharedPreferences? prefs;
  List<MyScore> list = [];

  sharedata() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        token = value.getString("token");
      });
    });
  }

  logout() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        // value.remove('name');
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
  Widget build(BuildContext context) {
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
            child: BlocProvider(
              create: (context) =>
                  InfoBloc(RepositoryProvider.of<Repository>(context))
                    ..add(LoadInfo()),
              child: BlocBuilder<InfoBloc, InfoState>(
                builder: (context, state) {
                  if (state is InfoLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is InfoLoadedState) {
                    InfoModel item = state.data;
                    // Obtain shared preferences.

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                IconButton(
                                    onPressed: () {
                                      logout();
                                    },
                                    icon: const Icon(
                                      Icons.logout_sharp,
                                      color: Colors.yellow,
                                    )),
                              ],
                            ),
                            normalText(
                                text: item.name, size: 24, color: lightgrey),
                            normalText(
                                text: item.mobile, size: 24, color: lightgrey),
                            // padd14,
                            buildListView(),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is InfoErrorState) {
                    return Container(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Column(
                          children: [
                            const Text('Somthing error please try again later'),
                            const SizedBox(height: 15.0),
                            TextButton(
                                onPressed: () {
                                  context.read<InfoBloc>().add(LoadInfo());
                                },
                                child: const Text('try again'))
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Text('Somthing error please try again later'),
                          const SizedBox(height: 15.0),
                          TextButton(
                              onPressed: () {
                                context.read<InfoBloc>().add(LoadInfo());
                              },
                              child: const Text('try again'))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }

  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
  Widget buildListView() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<MyScore>>(
        future: SqliteService.getItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padd20,
                  Lottie.asset(goldrcron,
                      height: 160, width: 170, fit: BoxFit.fill),
                  Row(
                    children: [
                      headingText(
                          text: 'My Scores', color: lightgrey, size: 18),
                    ],
                  ),
                  const Divider(color: Colors.orange),
                  SizedBox(
                      height: size.height - 150,
                      width: size.width,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // var items = snapshot.data!
                          //   ..sort((a, b) => b.id!.compareTo(a.id!));
                          var item = snapshot.data![index];
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    normalText(
                                        text: item.score.toString(),
                                        color: lightgrey),
                                    normalText(
                                        text: item.time.toString(),
                                        color: Colors.yellow),
                                  ],
                                ),
                                padd5,
                              ],
                            ),
                          );
                        },
                      ))
                ]),
          );
        });
  }
}
