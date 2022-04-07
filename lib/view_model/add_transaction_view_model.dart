import 'package:stoke_management/model/api_request/add_transaction_request.dart';
import 'package:stoke_management/model/api_response/add_transaction_model.dart';
import 'package:stoke_management/screen/add_transaction.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class AddTransactionViewModel {
  AddTransactionScreenState? state;
  InterceptorApi? interceptorApi;
  AddTransactionModel? addTransactionModel;
  AddTransactionRequest? addTransactionRequest;

  AddTransactionViewModel(AddTransactionScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callAddTransaction(AddTransactionRequest addTransactionRequest) async {
    print("==========callAddTransaction======="+addTransactionRequest.toString());
    addTransactionModel = (await interceptorApi!.callAddTransaction(addTransactionRequest));
    if(addTransactionModel != null){
      if(addTransactionModel!.success!){
        // await Shared_Preferences.prefSetString(App.KEY_USER_ID,loginModel!.items![0].userId.toString());
        // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      }
    }else{
    }
    print("==========callAddTransaction Api Responce=========="+addTransactionModel.toString());
  }
}