import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/models/result_model.dart';

var link = "https://opentdb.com/api.php?amount=20";
var lisn1 = "https://quizu.okoul.com/Questions";
var urlscore = "https://quizu.okoul.com/Score";

getQuiz() async {
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    print("data is loaded");
    return data;
  }
}

Future getQuiz1() async {
  // List<QuizModel> result = [];
  setHeadersToken() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM'
      };
  var res = await http.get(Uri.parse(lisn1), headers: setHeadersToken());

  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    // List data = jsonDecode(res.body.toString());
    // var result = data.map((e) => QuizModel.fromJson(e)).toList();
    // print("data is loaded");
    // print()
    return data;
  } else {
    throw Exception(res.reasonPhrase);

    // return result;
  }
}

Future updatescore(BuildContext context, score) async {
  Map data = {"score": 200};

  var body = json.encode(data);
  setHeadersToken() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mjk4LCJpYXQiOjE2NjM4OTQwOTN9.ZhsnQEEJKtSgW9br-r6t6MNOEDzxr1yy2kXfhq2kREc'
      };
  var res = await http.post(Uri.parse(urlscore),
      body: body, headers: setHeadersToken());

  try {
    var result = ResultModel.fromJson(jsonDecode(res.body));
    print(result.message);
    // print("data is loaded");
    if (result.success != null) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => RsultScreen()));
    }
    // print()
    return result;
  } catch (e) {
    throw Exception(res.reasonPhrase);
  }
}
