import 'package:stoke_management/model/api_response/stock_delete_model.dart';
import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
import 'package:stoke_management/screen/vendor_details_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class VendorDetailsViewModel {
  VenderDetailsScreenState? state;
  InterceptorApi? interceptorApi;
  VepariStockListModel? vepariStockListModel;
  StockDeleteModel? stockDeleteModel;

  VendorDetailsViewModel(VenderDetailsScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);

    // vepariStockListRequest = VepariStockListRequest(state.widget.vepariId.toString(), state.user_id_str.toString(), state.from_str.toString(), state.to_str.toString(), state.deviceType_str.toString(), state.deviceuid_str.toString(), state.token_str.toString());


    // callVepariStockModel(vepariStockListRequest!);
    callVepariStockModel(state.user_id_str.toString(), state.vepari_id_str.toString());
  }

  callVepariStockModel(String userId,String vepariId) async {
    print("==========callVepariListModel=======");
    vepariStockListModel = await interceptorApi!.callVepariStockModel(userId,vepariId);
    if(vepariStockListModel != null){
      state!.setState(() {
        state!.creditList = vepariStockListModel!.credit;
        state!.debitList = vepariStockListModel!.debit;
      });
    }
    print("==========VepariList Api Responce=========="+vepariStockListModel.toString());
  }


  callDeleteStock(String stockId) async {
    print("==========callUserRegister======="+stockId.toString());
    stockDeleteModel = (await interceptorApi!.callDeleteStock(stockId));
    if(stockDeleteModel != null){

    }else{
      print("-----user--first-login---");
    }
    print("==========register Api Responce=========="+stockDeleteModel.toString());
  }


}