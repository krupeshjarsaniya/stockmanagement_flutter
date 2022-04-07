import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
import 'package:stoke_management/screen/dashbord_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class DashBoardViewModel {
  DashBordScreenState? state;
  InterceptorApi? interceptorApi;
  VepariStockListModel? vepariStockListModel;

  DashBoardViewModel(DashBordScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callVepariStockList(String userId,String vepariId) async {
    print("==========callVepariStockList=======");
    vepariStockListModel = (await interceptorApi!.callVepariStockList(userId,vepariId));
    if(vepariStockListModel != null){

    }else{
      print("-----user--first-login---");
    }
    print("==========vepariStockListModel Api Responce=========="+vepariStockListModel.toString());
  }
}