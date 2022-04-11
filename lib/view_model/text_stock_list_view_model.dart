
import 'package:stoke_management/model/api_response/text_stock_list_model.dart';
import 'package:stoke_management/screen/note_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class TextStockListViewModel {
  NoteScreenState? state;
  InterceptorApi? interceptorApi;
  TextStockListModel? stockListModel;

  TextStockListViewModel(NoteScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
    callStockList(state.USER_ID.toString());
  }

  callStockList(String user_id) async {
   // print("==========Edit Vepari==========" + viewDetailrequest.toString());
    stockListModel = (await interceptorApi!.callStockList(user_id));
    if (stockListModel != null) {
      /*state!.setState(() {
        state!.item = vepariModel!.items;
      });*/
      // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Stock List Responce==========" + stockListModel.toString());
    }
  }
}