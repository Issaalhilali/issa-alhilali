import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/const/global.dart';
import 'package:quizu/data/api_const.dart';
import 'package:quizu/data/share_const.dart';
import 'package:quizu/models/info_model.dart';
import 'package:quizu/models/login_model.dart';
import 'package:quizu/models/result_model.dart';
import 'package:quizu/repository/const.dart';
import 'package:quizu/screens/home/home_screen.dart';
import 'package:quizu/screens/login/complete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  //for new user
  login(BuildContext context, String phone, String otp) async {
    var pref = await SharedPreferences.getInstance();
    Map data = {"OTP": otp, "mobile": phone};
    final body = json.encode(data);
    final url = Uri.parse(ApiCOnst.baseUrl + ApiCOnst.loginUrl);

    var response =
        await http.post(url, body: body, headers: ConstData.setHeaders());
    try {
      // if (response.statusCode == 20) {
      final result = LoginMode.fromJson(jsonDecode(response.body));
      final resultCeate = CreateModel.fromJson(jsonDecode(response.body));
      var resultmass = ResultModel.fromJson(jsonDecode(response.body));
      if (result.token != null) {
        pref.setString(ShareConst.shareToekn, result.token!);
        if (result.msg.toString() == "Token returning!") {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
          // ignore: use_build_context_synchronously
          messagesnackbar(context, "Welcome", Colors.green);
        } else {
          // ignore: use_build_context_synchronously
          if (resultCeate.msg == "user created!") {
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CompleteCreate()),
                (route) => false);
            // ignore: use_build_context_synchronously
            messagesnackbar(context, resultCeate.msg.toString(), Colors.green);
          } else {
            if (resultmass.message.toString() == "Token returning!") {
              // ignore: use_build_context_synchronously
              messagesnackbar(
                  context, resultmass.message.toString(), Colors.green);
            }
          }
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //OTP

  //for complete name
  completeCreate(BuildContext context, String token, String name) async {
    var pref = await SharedPreferences.getInstance();
    Map data = {"name": name};

    final body = json.encode(data);
    final url = Uri.parse(ApiCOnst.baseUrl + ApiCOnst.name);

    var response = await http.post(url,
        body: body, headers: ConstData.setHeadersToken(token));
    try {
      // if (response.statusCode == 20) {
      final result = NameMode.fromJson(jsonDecode(response.body));

      if (result.name != null) {
        pref.setString('name', result.name!);
        // print(result.name);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
        // ignore: use_build_context_synchronously
        messagesnackbar(context, 'Welcome ${result.name!}', Colors.green);
      }
      // }
      else {
        final result = errorlogin.fromJson(jsonDecode(response.body));
        // ignore: use_build_context_synchronously
        messagesnackbar(context, result.msg.toString(), Colors.red);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //for get info user
  Future<InfoModel> infoUser(token) async {
    final url = Uri.parse(ApiCOnst.baseUrl + ApiCOnst.infouser);
    var response =
        await http.get(url, headers: ConstData.setHeadersToken(token));
    try {
      // if (response.statusCode == 200) {
      final result = InfoModel.fromJson(jsonDecode(response.body));

      return result;
      // }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
