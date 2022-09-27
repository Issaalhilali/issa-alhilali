import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/const/text_style.dart';
import 'package:quizu/repository/auth/auth.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _isLoading = false;
  Repository repository = Repository();
  TextEditingController otpcontroll = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var onTapRecognizer;

  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  login() async {
    setState(() {
      _isLoading = true;
    });
    if (widget.phone.isNotEmpty) {
      await repository.login(context, widget.phone.trim(), otpcontroll.text);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepPurple,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            padd20,
            padd16,
            // Lottie.asset('name'),
            padd20,
            normalText(color: lightgrey, size: 16, text: "OTP Verification"),
            padd14,
            normalText(
                color: lightgrey,
                size: 16,
                text: "Enter OTP code send to your number \n ${widget.phone}"),
            Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: lightgrey,
                      fontWeight: FontWeight.bold,
                    ),

                    length: 4,
                    obscureText: false,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: lightgrey,
                        activeFillColor: lightgrey,
                        disabledColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        // selectedColor: Colors.grey,
                        inactiveFillColor: Colors.grey),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    textStyle: const TextStyle(fontSize: 20, height: 1.6),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: otpcontroll,
                    keyboardType: TextInputType.number,
                    // boxShadows: [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   )
                    // ],
                    onCompleted: (v) {
                      login();
                    },
                    // onTap: () {
                    //   login();
                    // },
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
            ),
            FadeInDown(
              delay: const Duration(milliseconds: 600),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  login();
                },
                color: lightgrey.withOpacity(0.8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: lightgrey,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "START",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "quick_semi",
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
