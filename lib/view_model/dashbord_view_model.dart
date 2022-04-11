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
    callDashBordModel(dashBordRequest!);
  }


  callDashBordModel(DashBordRequest dashBordRequest) async {
    print("==========Edit Vepari==========" + dashBordRequest.toString());
    dashBordModel = (await interceptorApi!.callDashBordModel(dashBordRequest));
    if (dashBordModel != null) {
      state!.setState(() {
        state!.dashBordModel = dashBordModel!;
        state!.totalCredit = dashBordModel!.totalCredit;
        state!.totalDebit = dashBordModel!.totalDebit;
        state!.totalBalance = dashBordModel!.balance;
      });
      print("==========Edit Vendor Api Responce==========" + dashBordModel.toString());
    }
  }

  // callDashBord(DashBordRequest dashBordRequest) async {
  //   print("==========Edit Vepari==========" + dashBordRequest.toString());
  //   dashBordModel = (await interceptorApi!.callDashBord(dashBordRequest));
  //
  //   if(dashBordModel!.success!){
  //     print("---s---");
  //   }
  //
  //
  //
  //   // if (dashBordModel != null) {
  //   //   print("---a---b");
  //   //
  //   //   state!.setState(() {
  //   //     state!.dashBordModel = dashBordModel!;
  //       state!.totalCredit = dashBordModel!.totalCredit;
  //       state!.totalDebit = dashBordModel!.totalDebit;
  //       state!.totalBalance = dashBordModel!.balance;
  //   //
  //   //
  //   //     print("---a---");
  //   //     print("---totalBal---" + dashBordModel!.totalDebit);
  //   //   });
  //   //   print("==========Edit Vendor Api Responce==========" + dashBordModel.toString());
  //   // }
  //
  //
  //
  // }
}