import 'package:stoke_management/model/api_request/Full_more_Request.dart';
import 'package:stoke_management/model/api_response/view_more_model.dart';
import 'package:stoke_management/screen/dashbord_screen.dart';
import 'package:stoke_management/screen/viewmore_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class ViewMoreViewModel {
  ViewMoreScreenState? state;
  InterceptorApi? interceptorApi;
  FullViewDetailModel? viewDetailModel;
  FullViewDetailrequest? viewDetailrequest;

  ViewMoreViewModel(ViewMoreScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
    viewDetailrequest = FullViewDetailrequest(state.USER_ID.toString(),"01/01/2015","01/01/2050",state.DEVICE_TYPE.toString(),state.DEVICE_ID.toString());
    callFullView(viewDetailrequest!);
  }

  callFullView(FullViewDetailrequest viewDetailrequest) async {
    print("==========Edit Vepari==========" + viewDetailrequest.toString());
    viewDetailModel = (await interceptorApi!.callFullView(viewDetailrequest));
    if (viewDetailModel != null) {
      state!.setState(() {
        state!.fullViewDetailModel = viewDetailModel!;
        state!.creditList = viewDetailModel!.credit;
        state!.debitList = viewDetailModel!.debit;
      });
      // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Edit Vendor Api Responce==========" + viewDetailModel.toString());
    }
  }
}