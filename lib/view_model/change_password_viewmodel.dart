import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/change_password_request.dart';
import 'package:stoke_management/model/api_response/change_password_model.dart';
import 'package:stoke_management/screen/change_password.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class ChangePasswordViewModel {
  ChangePasswordState? state;
  InterceptorApi? interceptorApi;
  ChangePasswordModel? changePasswordModel;
  ChangePasswordRequest? changePasswordRequest;

  ChangePasswordViewModel(ChangePasswordState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callChangePassword(ChangePasswordRequest changePasswordRequest) async {
    print("==========userLogIn===etger======="+changePasswordRequest.toString());
    changePasswordModel = (await interceptorApi!.callChangePassword(changePasswordRequest));
    if(changePasswordModel != null){
      if(changePasswordModel!.success!){
        Navigator.of(state!.context).pop();
      }
    }else{
      print("-----else---");
    }
    print("==========changePasswordModel Api Responce=========="+changePasswordModel.toString());
  }
}