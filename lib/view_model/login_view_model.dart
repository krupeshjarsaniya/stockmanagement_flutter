
import 'package:flutter/cupertino.dart';
import 'package:stoke_management/app.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/model/api_response/login_model.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/services/rest_api.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/widgets/common_toast.dart';

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
    await Shared_Preferences.prefSetBool(App.KEY_IS_LOGIN, true);

        await Shared_Preferences.prefSetString(App.KEY_USER_ID,loginModel!.items![0].userId.toString());
        await Shared_Preferences.prefSetString(App.KEY_FIRST_NAME,loginModel!.items![0].firstName.toString());
        await Shared_Preferences.prefSetString(App.KEY_LAST_NAME,loginModel!.items![0].lastName.toString());
        await Shared_Preferences.prefSetString(App.KEY_MOBILE_NUMBER,loginModel!.items![0].mobile.toString());
        commonToast(loginModel!.message.toString());
        Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      }
      commonToast(loginModel!.message.toString());

    }else{
      print("-----else---");
    }
    print("==========LogInPageView Api Responce=========="+loginModel.toString());
  }
}