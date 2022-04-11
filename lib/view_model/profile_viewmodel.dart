import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/logout_request.dart';
import 'package:stoke_management/model/api_response/logout_model.dart';
import 'package:stoke_management/screen/profile_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';

import '../app.dart';

class ProfileViewModel {
  ProfileScreenState? state;
  InterceptorApi? interceptorApi;
  LogoutModel? logoutModel;
  LogoutRequest? logoutRequest;

  ProfileViewModel(ProfileScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callLogOut(LogoutRequest logoutRequest) async {
    print("==========logoutRequest======="+logoutRequest.toString());
    logoutModel = (await interceptorApi!.callLogOut(logoutRequest));
    if(logoutModel != null){
      if(logoutModel!.success!){
        await Shared_Preferences.prefSetBool(App.KEY_IS_LOGIN, false);
        Navigator.pushReplacementNamed(state!.context, UtilRoutes.LoginScreen);
      }
    }else{

    }
    print("==========logoutModel Api Responce=========="+logoutModel.toString());
  }
}