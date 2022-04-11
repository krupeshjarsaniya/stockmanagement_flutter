import 'package:stoke_management/model/api_request/edit_stocks_request.dart';
import 'package:stoke_management/model/api_response/edit_stocks_model.dart';
import 'package:stoke_management/screen/edit_transaction_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class EditStocksViewModel {
  EditTransactionScreenState? state;
  InterceptorApi? interceptorApi;
  EditStocksModel? editStocksModel;
  EditStocksRequest? editStocksRequest;
  List<Item>? item;

  EditStocksViewModel(EditTransactionScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callEditStocks(EditStocksRequest editStocksRequest) async {
    print("==========Edit Stocks==========" + editStocksRequest.toString());
    editStocksModel = (await interceptorApi!.callEditStocks(editStocksRequest));
    if (editStocksModel != null) {
      /*state!.setState(() {
        state!.item = vepariModel!.items;
      });*/
      // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Edit Stocks Api Responce==========" + editStocksModel.toString());
    }
  }
}