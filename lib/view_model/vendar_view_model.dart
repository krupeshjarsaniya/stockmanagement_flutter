import 'package:stoke_management/model/api_response/vepari_list_model.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/services/interceptor_api.dart';

class VendorViewModel {
  VendorScreenState? state;
  InterceptorApi? interceptorApi;
  VepariListModel? vepariListModel;

  VendorViewModel(VendorScreenState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
    callVepariListModel(state.USER_ID.toString());
  }

  callVepariListModel(String userId) async {
    print("==========callVepariListModel======="+userId.toString());
    vepariListModel = (await interceptorApi!.callVepariListModel(userId));
    if(vepariListModel != null){

      state!.setState(() {
        state!.vepariList = vepariListModel!.items;
      });
    }
    print("==========VepariList Api Responce=========="+vepariListModel .toString());
  }
}