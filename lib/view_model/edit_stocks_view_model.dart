import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/delete_stoke_request.dart';
import 'package:stoke_management/model/api_request/edit_stocks_request.dart';
import 'package:stoke_management/model/api_response/edit_stocks_model.dart';
import 'package:stoke_management/model/api_response/stock_delete_model.dart';
import 'package:stoke_management/screen/edit_transaction_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class EditStocksViewModel {
  EditTransactionScreenState? state;
  InterceptorApi? interceptorApi;
  EditStocksModel? editStocksModel;
  EditStocksRequest? editStocksRequest;
  DeleteStockRequest? deleteStockRequest;
  StockDeleteModel? stockDeleteModel;


  EditStocksViewModel(EditTransactionScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callEditStocks(EditStocksRequest editStocksRequest) async {
    print("==========Edit Stocks==========" + editStocksRequest.toString());
    editStocksModel = (await interceptorApi!.callEditStocks(editStocksRequest));
    if (editStocksModel != null) {
      if(editStocksModel!.success!){
        commonToast(editStocksModel!.message.toString());
        Navigator.of(state!.context).pop();
      }
      commonToast(editStocksModel!.message.toString());

      print("==========Edit Stocks Api Responce==========" + editStocksModel.toString());
    }
  }

  callDeleteStock(DeleteStockRequest deleteStockRequest) async {
    print("==========callUserRegister=======");
    stockDeleteModel = (await interceptorApi!.callDeleteStock(deleteStockRequest));
    if(stockDeleteModel != null){
      if(stockDeleteModel!.success!){
        commonToast(stockDeleteModel!.message.toString());
        Navigator.of(state!.context).pop();
        state!.setState(() {
          // state!.creditList!.clear();
          // state!.debitList!.clear();
        });
      }
    }else{
      print("-----user--first-login---");
    }
    print("==========register Api Responce=========="+stockDeleteModel.toString());
  }


}