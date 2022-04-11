import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/add_vepari_request.dart';
import 'package:stoke_management/model/api_response/Add_vepari_model.dart';
import 'package:stoke_management/screen/add_vendors.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class AddVendorViewModel {
  AddVendorsState? state;
  InterceptorApi? interceptorApi;
  AddVepariModel? vepariModel;
  AddVepariRequest? vepariRequest;
  List<AddVepariModelItem>? item;

  AddVendorViewModel(AddVendorsState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callAddVendor(AddVepariRequest vepariRequest) async {
    print("==========Add Vepari==========" + vepariRequest.toString());
    vepariModel = (await interceptorApi!.callAddVendor(vepariRequest));
    if (vepariModel != null) {
      state!.setState(() {
        state!.item = vepariModel!.items;
      });
      if(vepariModel!.success!){
        commonToast(vepariModel!.message.toString());
        Navigator.of(state!.context).pop();
      }
       // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Add Vendor Api Responce==========" + vepariModel.toString());
    }
  }
}