import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quizu/const/colors.dart';
import 'package:quizu/const/images.dart';
import 'package:quizu/const/padd.dart';
import 'package:quizu/const/text_style.dart';
import 'package:quizu/screens/login/otp.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    // logi();
    super.initState();
  }

  login() {
    if (controller.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(phone: controller.text)));
    } else {
      throw Exception('Empty');
    }
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
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(quiz),
                  padd20,
                  padd20,
                  FadeInDown(
                    child: const Text(
                      'QUIZ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "quick_semi",
                          color: lightgrey),
                    ),
                  ),
                  padd20,
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Enter your phone number to continu, we will send you OTP to verifiy.',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: lightgrey,
                          fontFamily: "quick_semi",
                        ),
                      ),
                    ),
                  ),
                  padd16,
                  FadeInDown(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.13)),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color(0xffeeeeee),
                        //     blurRadius: 10,
                        //     offset: Offset(0, 4),
                        //   ),
                        // ],
                      ),
                      child: Stack(
                        children: [
                          InternationalPhoneNumberInput(
                            initialValue:
                                PhoneNumber(isoCode: 'SA', dialCode: ''),
                            onInputChanged: (PhoneNumber number) {},
                            onInputValidated: (bool value) {},
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            // autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle:
                                const TextStyle(color: Colors.black),
                            textFieldController: controller,
                            formatInput: false,
                            maxLength: 10,

                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            cursorColor: Colors.white.withOpacity(0.8),
                            inputDecoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 15, left: 0),
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 16),
                            ),
                            // onSaved: (PhoneNumber number) {
                            //   print('On Saved: $number');
                            // },
                          ),
                          Positioned(
                            left: 90,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              height: 40,
                              width: 1,
                              color: Colors.black.withOpacity(0.13),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // TextFormField(
                  //   controller: controller,
                  // ),
                  padd20,
                  padd20,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
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
                  padd20,
                  TextButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      child: normalText(
                          text: 'Developer by Issa Alhilali',
                          color: lightgrey)),
                ],
              ),
            ),
          ),
        )));
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://www.linkedin.com/in/issaalhilali/');

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
