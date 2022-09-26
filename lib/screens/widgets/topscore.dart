import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/bloc/info/info_bloc.dart';
import 'package:quizu/bloc/topscore/info_bloc.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/images.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/const/text_style.dart';

import 'package:quizu/models/info_model.dart';
import 'package:quizu/models/myscore.dart';
import 'package:quizu/models/topmode.dart';
import 'package:quizu/repository/api_services.dart';
import 'package:quizu/repository/auth/auth.dart';
import 'package:quizu/repository/sql/sql_score.dart';
import 'package:quizu/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopScore extends StatefulWidget {
  const TopScore({super.key});

  @override
  State<TopScore> createState() => _TopScoreState();
}

class _TopScoreState extends State<TopScore> {
  String? token;

  @override
  void initState() {
    sharedata();

    super.initState();
  }

  List<MyScore> sco = [];
  void _refreshNotes() async {
    final data = await SqliteService.getItems();
    setState(() {
      sco = data;
    });
  }

  SharedPreferences? prefs;
  List<MyScore> list = [];

  // initshared() async {
  //   prefs = await SharedPreferences.getInstance();
  //   localdata();
  // }

  // localdata() {
  //   // List<String> scor?? = list.map((e) => MyScore.fromJson(e)).toList()
  //   List<String> scor = prefs!.getStringList('list')!;

  //   setState(() {
  //     list = scor.map((e) => MyScore.fromJson(json.decode(e))).toList();
  //   });
  // }

  sharedata() async {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        token = value.getString("token");
      });
    });
  }

  // List<String>? items = [];
  // getSP() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     items = prefs.getStringList('myList');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) =>
            TopBloc(RepositoryProvider.of<APIService>(context))..add(LoadTop()),
        child: Scaffold(
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
              child: BlocBuilder<TopBloc, TopState>(
                builder: (context, state) {
                  if (state is TopLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TopLoadedState) {
                    List<TopModel> item = state.data;
                    // Obtain shared preferences.

                    return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padd20,
                              Lottie.asset(goldrcron,
                                  height: 160, width: 170, fit: BoxFit.fill),
                              Row(
                                children: [
                                  headingText(
                                      text: 'Top Scores',
                                      color: lightgrey,
                                      size: 18),
                                ],
                              ),
                              Divider(color: Colors.orange),
                              SizedBox(
                                height: size.height - 150,
                                width: size.width,
                                child: ListView.builder(
                                  itemCount: item.length,
                                  itemBuilder: (context, index) {
                                    var t = item[index];
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            normalText(
                                                text: t.name.toString(),
                                                color: lightgrey),
                                            normalText(
                                                text: t.score.toString(),
                                                color: Colors.yellow),
                                          ],
                                        ),
                                        padd5,
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ));
                  }
                  if (state is InfoErrorState) {
                    return Container();
                  }
                  return Container(
                    padding: const EdgeInsets.all(30.0),
                    margin: const EdgeInsets.only(top: 200, bottom: 30),
                    child: Center(
                      child: Column(
                        children: [
                          const Text('Somthing error please try again later'),
                          const SizedBox(height: 15.0),
                          TextButton(
                              onPressed: () {
                                // context.read<InfoBloc>().add(LoadInfo());
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
    return FutureBuilder<List<MyScore>>(
        future: SqliteService.getItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshot.data![index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.id.toString()),
                  Text(item.score.toString()),
                  Text(item.time.toString()),
                ],
              );
            },
          );
        });
  }
}
