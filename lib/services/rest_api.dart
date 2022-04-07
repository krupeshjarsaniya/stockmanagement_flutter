import 'package:flutter/cupertino.dart';
import 'package:stoke_management/app.dart';
import 'package:stoke_management/model/api_request/add_vepari_request.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
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


  Future<Response?> callVepariListModel(String userId) async {
    String url = App.baseUrl + App.vepari_list;
   // showLoader(_context);
    Response response;
    try {

      print("===========Map==========" + userId.toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"user_id": userId.toString()});
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


  Future<Response?> callVepariStockList(String userId,String vepariId) async {
    String url = App.baseUrl + App.vepari_stock_list;
   // showLoader(_context);
    Response response;
    try {

      print("===========Map=====userId=====" + userId.toString());
      print("===========Map======vepariId====" + vepariId.toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"user_id": userId.toString(),"vepari_id": vepariId.toString()});
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


  Future<Response?> callAddVendor(AddVepariRequest vepariRequest) async {
    String url = App.baseUrl + App.vepari_add;
    Response response;
    /*try {
      d.FormData formData = d.FormData();
      if(vepariRequest.image != null){
        String fileName = vepariRequest.image.path.substring(
            vepariRequest.image.path.lastIndexOf("/") + 1,
            vepariRequest.image.path.length);


        formData.files.add(
          MapEntry(
            "profile",
            d.MultipartFile.fromFileSync(vepariRequest.image.path,
                filename: fileName),
          ),
        );
        print("----file--->"+formData.files.toString());
       // formData.fields.add(MapEntry("image", vepariRequest.image));
        formData.fields.add(MapEntry("first_name", vepariRequest.first_name));
        formData.fields.add(MapEntry("last_name", vepariRequest.last_name));
        formData.fields.add(MapEntry("mobile", vepariRequest.mobile));
        formData.fields.add(MapEntry("company_name", vepariRequest.company_name));
        formData.fields.add(MapEntry("address", vepariRequest.address));
        formData.fields.add(MapEntry("email", vepariRequest.email));
      }else{
       // formData.fields.add(MapEntry("image", vepariRequest.image));
        formData.fields.add(MapEntry("first_name", vepariRequest.first_name));
        formData.fields.add(MapEntry("last_name", vepariRequest.last_name));
        formData.fields.add(MapEntry("mobile", vepariRequest.mobile));
        formData.fields.add(MapEntry("company_name", vepariRequest.company_name));
        formData.fields.add(MapEntry("address", vepariRequest.address));
        formData.fields.add(MapEntry("email", vepariRequest.email));
      }
      d.Response? response = null;
      print(url);
      d.Dio dio = d.Dio();
      dio.options.headers.addAll({App.HeaderName : App.HeaderValue});
      response = await dio.post(url, data: formData);
      print("===========Map==========" + vepariRequest.toMap().toString());
      print('Response request: ${response.requestOptions}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
      print(e);
      return null;
    }*/
    try {
      print("===========Map==========" + vepariRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body:
          //{"vepari_data" : vepariRequest.toMap().toString()});
          {"vepari_data" : vepariRequest.toMap().toString()});
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