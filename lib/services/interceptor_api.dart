import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
import 'package:stoke_management/model/api_request/logout_request.dart';
import 'package:stoke_management/model/api_request/register_device_request.dart';
import 'package:stoke_management/model/api_request/register_request.dart';
import 'package:stoke_management/model/api_request/vepari_stock_list_request.dart';
import 'package:stoke_management/model/api_response/Add_vepari_model.dart';
import 'package:stoke_management/model/api_response/add_transaction_model.dart';
import 'package:stoke_management/model/api_response/change_password_model.dart';
import 'package:stoke_management/model/api_response/dashbord_model.dart';
import 'package:stoke_management/model/api_response/edit_profile_model.dart';
import 'package:stoke_management/model/api_response/edit_stocks_model.dart';
import 'package:stoke_management/model/api_response/edit_vendor_model.dart';
import 'package:stoke_management/model/api_response/login_model.dart';
import 'package:stoke_management/model/api_response/logout_model.dart';
import 'package:stoke_management/model/api_response/register_device_model.dart';
import 'package:stoke_management/model/api_response/register_model.dart';
import 'package:stoke_management/model/api_response/stock_delete_model.dart';
import 'package:stoke_management/model/api_response/vepari_list_model.dart';
import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
import 'package:stoke_management/model/api_response/view_more_model.dart';
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
    // print("==========response===========" + response!.body.toString());
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


  Future<RegisterDeviceModel?> callRegisterDevice(RegisterDeviceRequest? registerDeviceRequest) async {
    var response = await restApi.callRegisterDevice(registerDeviceRequest);
    print("==========responce===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = RegisterDeviceModel.fromJson(data);

        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }

  Future<EditProfileModel?> callEditProfile(EditProfileRequest profileRequest) async {
    var response = await restApi.callEditProfile(profileRequest);
    print("==========response===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = EditProfileModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }



  Future<AddTransactionModel?> callAddTransaction(AddTransactionRequest addTransactionRequest) async {
    var response = await restApi.callAddTransaction(addTransactionRequest);
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = AddTransactionModel.fromJson(data);

        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }

  Future<EditVendorModel?> callEditVendor(EditVendorRequest editVendorRequest) async {
    var response = await restApi.callEditVendor(editVendorRequest);
    print("==========response===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = EditVendorModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }


  // Future<VepariStockListModel?> callVepariStockModel(String userId,String vepariId) async {
  //   var response = await restApi.callVepariStockModel(userId,vepariId);
  //   if (response == null) {}
  //   else if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data = jsonDecode(response.body.toString());
  //     if (response.statusCode == 200) {
  //       var response = VepariStockListModel.fromJson(data);
  //       return response;
  //     }
  //   } else if (response.statusCode == 500) {
  //     var data = jsonDecode(response.body);
  //     String msg = data['message'];
  //   } else {}
  // }
  //
 Future<VepariStockListModel?> callVepariStockModel(VepariStockListRequest vepariStockListRequest) async {
    var response = await restApi.callVepariStockModel(vepariStockListRequest);
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = VepariStockListModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }



  // Future<StockDeleteModel?> callDeleteStock(String stockId) async {
  //   var response = await restApi.callDeleteStock(stockId);
  //   if (response == null) {}
  //   else if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data = jsonDecode(response.body.toString());
  //     if (response.statusCode == 200) {
  //       var response = StockDeleteModel.fromJson(data);
  //       return response;
  //     }
  //   } else if (response.statusCode == 500) {
  //     var data = jsonDecode(response.body);
  //     String msg = data['message'];
  //   } else {}
  // }

  Future<StockDeleteModel?> callDeleteStock(DeleteStockRequest deleteStockRequest) async {
    var response = await restApi.callDeleteStock(deleteStockRequest);
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = StockDeleteModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }


  Future<ChangePasswordModel?> callChangePassword(ChangePasswordRequest changePasswordRequest) async {
    var response = await restApi.callChangePassword(changePasswordRequest);
    print("==========responce===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var response = ChangePasswordModel.fromJson(data);

        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }


  Future<EditStocksModel?> callEditStocks(EditStocksRequest editStocksRequest) async {
    var response = await restApi.callEditStocks(editStocksRequest);
    print("==========response===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = EditStocksModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }



  Future<LogoutModel?> callLogOut(LogoutRequest logoutRequest) async {
    var response = await restApi.callLogOut(logoutRequest);
    print("==========response===========" + response!.body.toString());
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = LogoutModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }

  Future<FullViewDetailModel?> callFullView(FullViewDetailrequest viewDetailrequest) async {
    var response = await restApi.callFullView(viewDetailrequest);
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = FullViewDetailModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }

  Future<DashBordModel?> callDashBord(DashBordRequest dashBordRequest) async {
    var response = await restApi.callDashBord(dashBordRequest);
    if (response == null) {}
    else if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var response = DashBordModel.fromJson(data);
        return response;
      }
    } else if (response.statusCode == 500) {
      var data = jsonDecode(response.body);
      String msg = data['message'];
    } else {}
  }

}







