import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/bloc/info_bloc.dart';
import 'package:quizu/models/info_model.dart';
import 'package:quizu/repository/auth/auth.dart';
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
    return BlocProvider(
      create: (context) =>
          InfoBloc(RepositoryProvider.of<Repository>(context))..add(LoadInfo()),
      child: Scaffold(
        body: BlocBuilder<InfoBloc, InfoState>(
          builder: (context, state) {
            if (state is InfoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is InfoLoadedState) {
              InfoModel item = state.data;
              return Padding(
                padding: const EdgeInsets.all(20.0),
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
                  ],
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
    );
  }
}
