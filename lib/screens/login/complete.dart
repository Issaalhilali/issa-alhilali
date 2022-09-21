import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizu/repository/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteCreate extends StatefulWidget {
  const CompleteCreate({super.key});

  @override
  State<CompleteCreate> createState() => _CompleteCreateState();
}

class _CompleteCreateState extends State<CompleteCreate> {
  String? token;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(token.toString()),
              TextFormField(
                controller: namestr,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    // errorBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.red, width: 1.0),
                    //   borderRadius: BorderRadius.circular(25.0),
                    // ),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    labelText: 'Username'),
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
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        createUser();
                      },
                      child: const Text('Start'))
            ],
          ),
        ),
      ),
    );
  }
}
