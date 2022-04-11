import 'package:stoke_management/model/api_request/dashbord_request.dart';
import 'package:stoke_management/model/api_request/delete_stoke_request.dart';
import 'package:stoke_management/model/api_request/vepari_stock_list_request.dart';
import 'package:stoke_management/model/api_response/dashbord_model.dart';
import 'package:stoke_management/model/api_response/stock_delete_model.dart';
import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
import 'package:stoke_management/screen/vendor_details_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class VendorDetailsViewModel {
  VenderDetailsScreenState? state;
  InterceptorApi? interceptorApi;
  VepariStockListModel? vepariStockListModel;
  StockDeleteModel? stockDeleteModel;
  DashBordModel? dashBordModel;
  DashBordRequest? dashBordRequest;
  VepariStockListRequest? vepariStockListRequest;
  DeleteStockRequest? deleteStockRequest;

  VendorDetailsViewModel(VenderDetailsScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);

    vepariStockListRequest = VepariStockListRequest(state.widget.vepariId.toString(), state.user_id_str.toString(), state.from_str.toString(), state.to_str.toString(), state.deviceType_str.toString(), state.deviceuid_str.toString(), state.token_str.toString());


    callVepariStockModel(vepariStockListRequest!);
    // callVepariStockModel(state.user_id_str.toString(), state.vepari_id_str.toString());
    dashBordRequest = DashBordRequest(state.user_id_str.toString(),state.token_str.toString(),state.deviceType_str.toString(),state.deviceuid_str.toString());
    callDashBord(dashBordRequest!);
  }

  // callVepariStockModel(String userId,String vepariId) async {
  //   print("==========callVepariListModel=======");
  //   vepariStockListModel = await interceptorApi!.callVepariStockModel(userId,vepariId);
  //   if(vepariStockListModel != null){
  //     state!.setState(() {
  //       state!.creditList = vepariStockListModel!.credit;
  //       state!.debitList = vepariStockListModel!.debit;
  //     });
  //   }
  //   print("==========VepariList Api Responce=========="+vepariStockListModel.toString());
  // }

  callVepariStockModel(VepariStockListRequest vepariStockListRequest) async {
    print("==========callVepariListModel=======");
    vepariStockListModel = await interceptorApi!.callVepariStockModel(vepariStockListRequest);
    if(vepariStockListModel != null){
      state!.setState(() {
        state!.creditList = vepariStockListModel!.credit;
        state!.debitList = vepariStockListModel!.debit;
      });
    }
    print("==========VepariList Api Responce=========="+vepariStockListModel.toString());
  }

  callDashBord(DashBordRequest dashBordRequest) async {
    print("==========Edit Vepari==========" + dashBordRequest.toString());
    dashBordModel = (await interceptorApi!.callDashBord(dashBordRequest));
    if (dashBordModel != null) {
      state!.setState(() {
        state!.dashBordModel = dashBordModel!;

      });
      print("==========Edit Vendor Api Responce==========" + dashBordModel.toString());
    }
  }


  // callDeleteStock(String stockId) async {
  //   print("==========callUserRegister======="+stockId.toString());
  //   stockDeleteModel = (await interceptorApi!.callDeleteStock(stockId));
  //   if(stockDeleteModel != null){
  //
  //   }else{
  //     print("-----user--first-login---");
  //   }
  //   print("==========register Api Responce=========="+stockDeleteModel.toString());
  // }

  callDeleteStock( DeleteStockRequest deleteStockRequest) async {
    print("==========callUserRegister=======");
    stockDeleteModel = (await interceptorApi!.callDeleteStock(deleteStockRequest));
    if(stockDeleteModel != null){

    }else{
      print("-----user--first-login---");
    }
    print("==========register Api Responce=========="+stockDeleteModel.toString());
  }


}