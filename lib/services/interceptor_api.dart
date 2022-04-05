import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/model/api_response/login_model.dart';
import 'package:stoke_management/services/rest_api.dart';

class InterceptorApi {
  late BuildContext _context;
  late RestApi restApi;

  InterceptorApi({context}) {
    _context = context;
    restApi = RestApi(context: context);
  }

  Future<LoginModel?> callUserLogIn(UserLogInRequest logInRequest) async {
    var response = await restApi.callUserLogIn(logInRequest);
    print("==========responce===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = LoginModel.fromJson(data);

        return response;
      }
      } else if (response.statusCode == 500) {
        var data = jsonDecode(response.body);
        String msg = data['message'];
      } else {}
    }
  }


