
import 'package:flutter/cupertino.dart';
import 'package:stoke_management/app.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/model/api_response/login_model.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/services/rest_api.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class LoginViewModel {
  LoginScreenState? state;
  InterceptorApi? interceptorApi;
  LoginModel? loginModel;
  UserLogInRequest? logInRequest;

  LoginViewModel(LoginScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callUserLogIn(UserLogInRequest logInRequest) async {
    print("==========userLogIn===etger======="+logInRequest.toString());
    loginModel = (await interceptorApi!.callUserLogIn(logInRequest));
    if(loginModel != null){
      if(loginModel!.success!){
        await Shared_Preferences.prefSetString(App.KEY_USER_ID,loginModel!.items![0].userId.toString());
        Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      }
    }else{
      print("-----else---");
    }
    print("==========LogInPageView Api Responce=========="+loginModel.toString());
  }
}