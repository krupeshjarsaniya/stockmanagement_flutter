
import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_response/forgot_password_model.dart';
import 'package:stoke_management/screen/forgot_password_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class ForgotPasswordViewModel {
  ForgotPasswordScreenState? state;
  InterceptorApi? interceptorApi;
  ForgotPasswordModel? forgotPasswordModel;

  ForgotPasswordViewModel(ForgotPasswordScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callForgotPassword(String email) async {
    print("==========callForgotPassword=========="+email.toString());
    forgotPasswordModel = (await interceptorApi!.callForgotPassword(email));
    if(forgotPasswordModel != null){
      if(forgotPasswordModel!.success!){

        commonToast(forgotPasswordModel!.message.toString());
        Navigator.of(state!.context).pop();        // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      }
      commonToast(forgotPasswordModel!.message.toString());

    }else{
      print("-----else---");
    }
    print("==========LogInPageView Api Responce=========="+forgotPasswordModel.toString());
  }
}