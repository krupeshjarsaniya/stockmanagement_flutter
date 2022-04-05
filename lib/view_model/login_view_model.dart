import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/model/api_response/login_model.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/services/rest_api.dart';

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

    }else{
      print("-----else---");
    }
    print("==========LogInPageView Api Responce=========="+loginModel.toString());
  }
}