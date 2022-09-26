import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/bloc/info/info_bloc.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/padd.dart';

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
                          children: [
                            Row(
                              children: [
                                Container(),
                                IconButton(
                                    onPressed: () {
                                      logout();
                                    },
                                    icon: const Icon(Icons.logout_sharp))
                              ],
                            ),
                            Text(item.name!),
                            Text(item.mobile!),
                            padd20,
                            Divider(),
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 500,
                                  width: double.infinity,
                                  child: buildListView(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
              var items = snapshot.data!
                ..sort((a, b) => b.id!.compareTo(a.id!));
              var item = items[index];
              return SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.score.toString()),
                    Text(item.time.toString()),
                  ],
                ),
              );
            },
          );
        });
  }
}
