
import 'package:flutter/cupertino.dart';
import 'package:stoke_management/model/api_request/edit_vendor_request.dart';
import 'package:stoke_management/model/api_response/edit_vendor_model.dart';
import 'package:stoke_management/screen/edit_vendor.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class EditVendorViewModel {
  EditVendorState? state;
  InterceptorApi? interceptorApi;
  EditVendorModel? editVendorModel;
  EditVendorRequest? editVendorRequest;
  List<Item>? item;

  EditVendorViewModel(EditVendorState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callEditVendor(EditVendorRequest editVendorRequest) async {
    print("==========Edit Vepari==========" + editVendorRequest.toString());
    editVendorModel = (await interceptorApi!.callEditVendor(editVendorRequest));
    if (editVendorModel != null) {
      if(editVendorModel!.success!){
        commonToast(editVendorModel!.message.toString());
        Navigator.pop(state!.context,state!.firstName.text.toString());

      }
      print("==========Edit Vendor Api Responce==========" + editVendorModel.toString());
    }
  }
}