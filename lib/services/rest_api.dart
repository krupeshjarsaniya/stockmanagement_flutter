import 'package:flutter/cupertino.dart';
import 'package:stoke_management/app.dart';
import 'package:stoke_management/model/api_request/Full_more_Request.dart';
import 'package:stoke_management/model/api_request/add_transaction_request.dart';
import 'package:stoke_management/model/api_request/add_vepari_request.dart';
import 'package:stoke_management/model/api_request/change_password_request.dart';
import 'package:stoke_management/model/api_request/dashbord_request.dart';
import 'package:stoke_management/model/api_request/delete_stoke_request.dart';
import 'package:stoke_management/model/api_request/edit_profile_request.dart';
import 'package:stoke_management/model/api_request/edit_stocks_request.dart';
import 'package:stoke_management/model/api_request/edit_vendor_request.dart';
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
import 'package:stoke_management/model/api_request/logout_request.dart';
import 'package:stoke_management/model/api_request/register_device_request.dart';
import 'package:stoke_management/model/api_request/register_request.dart';
import 'package:http/http.dart' as http;
import 'package:stoke_management/model/api_request/vepari_stock_list_request.dart';
import 'package:stoke_management/widgets/common_route.dart';
import '../app.dart';

class RestApi {
  late BuildContext _context;

  RestApi({context}) {
    _context = context;
  }


  Future<Response?> callUserLogIn(UserLogInRequest logInRequest) async {
    String url = App.baseUrl + App.login;
   showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + logInRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: logInRequest.toMap());
     hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

     hideLoader();
      return null;
    }
  }

  Future<Response?> callUserRegister(UserRegisterRequest userRegisterRequest) async {
    String url = App.baseUrl + App.register;
   showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + userRegisterRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: userRegisterRequest.toMap());
     hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

     hideLoader();
      return null;
    }
  }


  Future<Response?> callVepariListModel(String userId) async {
    String url = App.baseUrl + App.vepari_list;
   showLoader(_context);
    Response response;
    try {

      print("===========Map==========" + userId.toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"user_id": userId.toString()});
     hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

     hideLoader();
      return null;
    }
  }

  //
  // Future<Response?> callVepariStockList(String userId,String vepariId) async {
  //   String url = App.baseUrl + App.vepari_stock_list;
  //  showLoader(_context);
  //   Response response;
  //   try {
  //
  //     print("===========Map=====userId=====" + userId.toString());
  //     print("===========Map======vepariId====" + vepariId.toString());
  //
  //     response = await http.post(
  //         Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
  //         body: {"user_id": userId.toString(),"vepari_id": vepariId.toString()});
  //    hideLoader();
  //     print('Response request: ${response.request}');
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     return response;
  //   } catch (e) {
  //     print("===EXCEPTION==="  + e.toString());
  //
  //    hideLoader();
  //     return null;
  //   }
  // }


  Future<Response?> callAddVendor(AddVepariRequest vepariRequest) async {
    String url = App.baseUrl + App.vepari_add;
    Response response;
    showLoader(_context);

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
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }


  Future<Response?> callRegisterDevice(RegisterDeviceRequest? registerDeviceRequest) async {
    String url = App.baseUrl + App.register_device;
    showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + registerDeviceRequest!.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: registerDeviceRequest.toMap());
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

       hideLoader();
      return null;
    }
  }


  Future<Response?> callEditProfile(EditProfileRequest profileRequest) async {
    String url = App.baseUrl + App.profile_edit;
    showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + profileRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: profileRequest.toMap());
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }


  Future<Response?> callAddTransaction(AddTransactionRequest addTransactionRequest) async {
    String url = App.baseUrl + App.stock_add;
    showLoader(_context);

    Response response;
    try {
      print("===========Map==========" + addTransactionRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"stock_data" : '['+addTransactionRequest.toMap().toString()+']' });
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      // return null;
    }
  }

  Future<Response?> callEditVendor(EditVendorRequest editVendorRequest) async {
    String url = App.baseUrl + App.vepari_edit;
    showLoader(_context);

    Response response;
    try {
      print("===========Map==========" + editVendorRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"vepari_data" : '['+editVendorRequest.toMap().toString()+']' });

      // {"vepari_data" : editVendorRequest.toMap().toString()}

       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }
//
// Future<Response?> callVepariStockModel(String userId,String vepariId) async {
//     String url = App.baseUrl + App.vepari_stock_list;
//     showLoader(_context);
//
//     Response response;
//
//     try {
//       print("===========Map======userId====" + userId.toString());
//       print("===========Map======vepariId====" + vepariId.toString());
//
//       response = await http.post(
//           Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
//           body:{"user_id": userId.toString(),"vepari_id":vepariId.toString()});
//
//       // {"vepari_data" : editVendorRequest.toMap().toString()}
//
//        hideLoader();
//       print('Response request: ${response.request}');
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       return response;
//     } catch (e) {
//       print("===EXCEPTION==="  + e.toString());
//        hideLoader();
//       return null;
//     }
//   }

Future<Response?> callVepariStockModel(VepariStockListRequest vepariStockListRequest) async {
    String url = App.baseUrl + App.vepari_stock_list;
    Response response;
    showLoader(_context);
    try {
      print("===========Map=========" + vepariStockListRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body:vepariStockListRequest.toMap());

      // {"vepari_data" : editVendorRequest.toMap().toString()}

       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }

Future<Response?> callVepariStockModelLoader(VepariStockListRequest vepariStockListRequest) async {
    String url = App.baseUrl + App.vepari_stock_list;
    Response response;
    // showLoader(_context);
    try {
      print("===========Map=========" + vepariStockListRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body:vepariStockListRequest.toMap());

      // {"vepari_data" : editVendorRequest.toMap().toString()}

       // hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       // hideLoader();
      return null;
    }
  }



  // Future<Response?> callDeleteStock(String stockId) async {
  //   String url = App.baseUrl + App.stock_delete;
  //   showLoader(_context);
  //   Response response;
  //   try {
  //     print("===========Map=====stockId=====" + stockId.toString());
  //     response = await http.post(
  //         Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
  //         // body: {"stock_delete_data": stockId.toString()});
  //         // body: {"stock_delete_data": {"stock_id" : stockId.toString()}
  //         body: {"stock_delete_data": '[{'+ "stock_id" +  '"'+stockId.toString()+'"'+'}]'
  //
  //
  //         });
  //      hideLoader();
  //     print('Response request: ${response.request}');
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     return response;
  //   } catch (e) {
  //     print("===EXCEPTION==="  + e.toString());
  //
  //      hideLoader();
  //     return null;
  //   }
  // }

  Future<Response?> callDeleteStock(DeleteStockRequest deleteStockRequest) async {
    String url = App.baseUrl + App.stock_delete;
    // showLoader(_context);
    Response response;
    try {
      print("===========Map=====stockId=====" + deleteStockRequest.toMap().toString());
      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          // body: {"stock_delete_data": stockId.toString()});
          // body: {"stock_delete_data": {"stock_id" : stockId.toString()}
          // body: {"stock_delete_data": '[{'+ "stock_id" +  '"'+stockId.toString()+'"'+'}]'
          body: {"stock_delete_data" : '['+deleteStockRequest.toMap().toString()+']' });

       // hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

       // hideLoader();
      return null;
    }
  }

  Future<Response?> callChangePassword(ChangePasswordRequest changePasswordRequest) async {
    String url = App.baseUrl + App.change_password;
    showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + changePasswordRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: changePasswordRequest.toMap());
      hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());

      hideLoader();
      return null;
    }
  }

  Future<Response?> callEditStocks(EditStocksRequest editStocksRequest) async {
    String url = App.baseUrl + App.stock_edit;
    showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + editStocksRequest.toMap().toString());
      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"stock_update_data" : '['+editStocksRequest.toMap().toString()+']' });
      hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }



  Future<Response?> callLogOut(LogoutRequest logoutRequest) async {
    String url = App.baseUrl + App.logout;
    showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + logoutRequest.toMap().toString());
      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: logoutRequest.toMap());
      hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }

  Future<Response?> callFullView(FullViewDetailrequest viewDetailrequest) async {
    String url = App.baseUrl + App.full_view_details;
    showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + viewDetailrequest.toMap().toString());
      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: viewDetailrequest.toMap());
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }

  Future<Response?> callDashBord(DashBordRequest dashBordRequest) async {
    String url = App.baseUrl + App.dashboard;
    // showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + dashBordRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: dashBordRequest.toMap());
       // hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       // hideLoader();
      return null;
    }
  }



  Future<Response?> callDashBordWithOutLoader(DashBordRequest dashBordRequest) async {
    String url = App.baseUrl + App.dashboard;
    // showLoader(_context);
    Response response;
    try {
      print("===========Map==========" + dashBordRequest.toMap().toString());

      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: dashBordRequest.toMap());
      // hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
      // hideLoader();
      return null;
    }
  }


  Future<Response?> callStockList(String user_id) async {
    String url = App.baseUrl + App.text_stock_list;
    showLoader(_context);
    Response response;
    try {
      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"user_id" : user_id.toString()});
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }


  Future<Response?> callForgotPassword(String user_id) async {
    String url = App.baseUrl + App.forgot_password;
    showLoader(_context);
    Response response;
    try {
      response = await http.post(
          Uri.parse(url), headers: {App.HeaderName : App.HeaderValue},
          body: {"email" : user_id.toString()});
       hideLoader();
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("===EXCEPTION==="  + e.toString());
       hideLoader();
      return null;
    }
  }


}