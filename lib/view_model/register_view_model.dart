import 'package:stoke_management/model/api_request/register_request.dart';
import 'package:stoke_management/model/api_response/register_model.dart';
import 'package:stoke_management/screen/register_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class RegisterViewModel {
  RegisterScreenState? state;
  InterceptorApi? interceptorApi;
  RegisterModel? registerModel;
  UserRegisterRequest? userRegisterRequest;

  RegisterViewModel(RegisterScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callUserRegister(UserRegisterRequest userRegisterRequest) async {
    print("==========callUserRegister======="+userRegisterRequest.toString());
    registerModel = (await interceptorApi!.callUserRegister(userRegisterRequest));
    if(registerModel != null){

    }else{
      print("-----user--first-login---");
    }
    print("==========register Api Responce=========="+registerModel.toString());
  }
}