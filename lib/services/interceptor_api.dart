import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/add_vepari_request.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/model/api_request/register_request.dart';
import 'package:stoke_management/model/api_response/Add_vepari_model.dart';
import 'package:stoke_management/model/api_response/login_model.dart';
import 'package:stoke_management/model/api_response/register_model.dart';
import 'package:stoke_management/model/api_response/vepari_list_model.dart';
import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
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


  Future<RegisterModel?> callUserRegister(UserRegisterRequest userRegisterRequest) async {
    var response = await restApi.callUserRegister(userRegisterRequest);
    print("==========responce===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = RegisterModel.fromJson(data);

        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }


  Future<VepariListModel?> callVepariListModel(String useId) async {
    var response = await restApi.callVepariListModel(useId);
    print("==========responce===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = VepariListModel.fromJson(data);

        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }


  Future<VepariStockListModel?> callVepariStockList(String useId,String vepariId) async {
    var response = await restApi.callVepariStockList(useId,vepariId);
    print("==========responce===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = VepariStockListModel.fromJson(data);

        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }


  Future<AddVepariModel?> callAddVendor(AddVepariRequest vepariRequest) async {
    var response = await restApi.callAddVendor(vepariRequest);
    print("==========response===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = AddVepariModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }




}







