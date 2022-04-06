import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:http/http.dart' as http;
import '../app.dart';

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
}