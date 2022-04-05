import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/login_request.dart';

class RestApi {
  late BuildContext _context;

  RestApi({context}) {
    _context = context;
  }
  Future<Response?> callUserLogIn(UserLogInRequest logInRequest) async {
    String url = appState.host + App.userLogin;
   // showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + logInRequest.toMap().toString());
      response = await http.post(
          Uri.parse(url), headers: await App.getUserToken(),
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