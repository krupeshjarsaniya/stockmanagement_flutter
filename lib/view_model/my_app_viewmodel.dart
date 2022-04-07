import 'package:stoke_management/model/api_request/register_device_request.dart';
import 'package:stoke_management/model/api_response/register_device_model.dart';
import 'package:stoke_management/services/interceptor_api.dart';

import '../main.dart';

class MyAppViewModel {
  MyAppState? state;
  InterceptorApi? interceptorApi;
  RegisterDeviceModel? registerDeviceModel;
  RegisterDeviceRequest? registerDeviceRequest;

  MyAppViewModel(MyAppState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callRegisterDevice(RegisterDeviceRequest? registerDeviceRequest) async {
    print("==========callUserRegister======="+registerDeviceRequest.toString());
    registerDeviceModel = (await interceptorApi!.callRegisterDevice(registerDeviceRequest));
    if(registerDeviceModel != null){

    }else{
    }
    print("==========callRegisterDevice Api Responce=========="+registerDeviceModel.toString());
  }
}