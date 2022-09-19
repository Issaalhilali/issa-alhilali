import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/data/api_const.dart';
import 'package:quizu/data/share_const.dart';
import 'package:quizu/models/login_model.dart';
import 'package:quizu/screens/otp/otp_screen.dart';
import 'package:quizu/utli/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  void login(BuildContext context, String phone) async {
    var pref = await SharedPreferences.getInstance();
    Map data = {"OTP": "0000", "mobile": phone};
    final body = json.encode(data);
    final url = Uri.parse(ApiCOnst.baseUrl + ApiCOnst.loginUrl);

    var response = await http.post(url, body: body);
    try {
      if (response.statusCode == 200) {
        final result = LoginModel.fromJson(jsonDecode(response.body));
        if (result.token != null) {
          pref.setString(ShareConst.shareToekn, result.token!);

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OtpScreen()),
              (route) => false);
          // ignore: use_build_context_synchronously
          messagesnackbar(context, 'Welcome', Colors.green);
        }
      } else {
        Map resulterror = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        messagesnackbar(context, resulterror.values.first, Colors.red);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
