import 'package:flutter/cupertino.dart';
import 'package:stoke_management/app.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stoke_management/model/api_request/register_request.dart';



class RestApi {
  late BuildContext _context;

  RestApi({context}) {
    _context = context;
  }


  Future<Response?> callUserLogIn(UserLogInRequest logInRequest) async {
    String url = App.baseUrl + App.login;
   // showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + logInRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: logInRequest.toMap());
    //  hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

    //  hideLoader();
      return null;
    }
  }

  Future<Response?> callUserRegister(UserRegisterRequest userRegisterRequest) async {
    String url = App.baseUrl + App.register;
   // showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + userRegisterRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: userRegisterRequest.toMap());
    //  hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

    //  hideLoader();
      return null;
    }
  }




}