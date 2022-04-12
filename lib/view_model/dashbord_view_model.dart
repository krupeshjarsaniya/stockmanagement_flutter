import 'package:stoke_management/model/api_request/Full_more_Request.dart';
import 'package:stoke_management/model/api_request/dashbord_request.dart';
import 'package:stoke_management/model/api_response/dashbord_model.dart';
import 'package:stoke_management/model/api_response/view_more_model.dart';
import 'package:stoke_management/screen/dashbord_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class DashBordViewModel {
  DashBordScreenState? state;
  InterceptorApi? interceptorApi;
  DashBordModel? dashBordModel;
  DashBordRequest? dashBordRequest;

  DashBordViewModel(DashBordScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
    dashBordRequest = DashBordRequest(state.USER_ID.toString(),state.DEVICE_TOKEN.toString(),state.DEVICE_TYPE.toString(),state.DEVICE_ID.toString());
    callDashBord(dashBordRequest!);
  }

  callDashBord(DashBordRequest dashBordRequest) async {
    print("==========callDashBordModel=========" + dashBordRequest.toString());
    dashBordModel = (await interceptorApi!.callDashBord(dashBordRequest));
    if (dashBordModel != null) {
      state!.setState(() {
        state!.totalCredit = double.parse(dashBordModel!.totalCredit);
        state!.totalDebit = double.parse(dashBordModel!.totalDebit);
        state!.totalBalance = double.parse(dashBordModel!.balance);
        state!.dashBordModel = dashBordModel!;
        print("---balance---" + dashBordModel!.balance);
      });
      print("=========callDashBordModel Responce==========" + dashBordModel.toString());
    }
  }
}