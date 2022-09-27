import 'package:flutter/material.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/repository/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteCreate extends StatefulWidget {
  const CompleteCreate({super.key});

  @override
  State<CompleteCreate> createState() => _CompleteCreateState();
}

class _CompleteCreateState extends State<CompleteCreate> {
  String? token;
  String? name;
  TextEditingController namestr = TextEditingController();
  Repository repository = Repository();
  bool _isLoading = false;

  @override
  void initState() {
    fecthData();
    super.initState();
  }

  fecthData() async {
    SharedPreferences.getInstance().then((share) {
      setState(() {
        token = share.getString('token');
        name = share.getString('name');
      });
    });
  }

  createUser() async {
    setState(() {
      _isLoading = true;
    });
    await repository.completeCreate(context, token!, namestr.text);
    setState(() {
      _isLoading = false;
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: namestr,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.greenAccent, width: 1.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.red, width: 1.0),
                      //   borderRadius: BorderRadius.circular(25.0),
                      // ),
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.person,
                        color: lightgrey,
                      ),
                      labelText: 'Enter your Name',
                      hintStyle: const TextStyle(color: lightgrey)),
                  onChanged: (value) {
                    // user.username=value;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter username';
                  //   }
                  //   return null;
                  // },
                ),
                padd20,
                padd20,
                _isLoading
                    ? const CircularProgressIndicator()
                    : MaterialButton(
                        minWidth: double.infinity,
                        color: lightgrey.withOpacity(0.8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        onPressed: () {
                          createUser();
                        },
                        child: const Text('Start'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
