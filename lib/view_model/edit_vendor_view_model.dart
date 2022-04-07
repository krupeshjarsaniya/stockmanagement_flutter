
import 'package:stoke_management/model/api_request/edit_vendor_request.dart';
import 'package:stoke_management/model/api_response/edit_vendor_model.dart';
import 'package:stoke_management/screen/edit_vendor.dart';
import 'package:stoke_management/services/interceptor_api.dart';

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
      /*state!.setState(() {
        state!.item = vepariModel!.items;
      });*/
      // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Edit Vendor Api Responce==========" + editVendorModel.toString());
    }
  }
}