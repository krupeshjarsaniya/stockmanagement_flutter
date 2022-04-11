
import 'package:flutter/cupertino.dart';
import 'package:stoke_management/app.dart';
import 'package:stoke_management/model/api_request/edit_profile_request.dart';
import 'package:stoke_management/model/api_response/edit_profile_model.dart';
import 'package:stoke_management/screen/edit_profile.dart';
import 'package:stoke_management/services/interceptor_api.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class EditProfileViewModel {
  EditProfileState? state;
  InterceptorApi? interceptorApi;
  EditProfileModel? editProfileModel;
  EditProfileRequest? editProfileRequest;
  List<Item>? item;

  EditProfileViewModel(EditProfileState state) {
    this.state = state;
    interceptorApi = InterceptorApi(context: state.context);
  }

  callEditProfile(EditProfileRequest profileRequest) async {
    print("==========Profile Edit==========" + profileRequest.toString());
    editProfileModel = (await interceptorApi!.callEditProfile(profileRequest));
    if (editProfileModel != null) {

      if(editProfileModel!.success!){
        commonToast(editProfileModel!.message.toString());
        await Shared_Preferences.prefSetString(App.KEY_FIRST_NAME, editProfileModel!.items![0].firstName.toString());
        await Shared_Preferences.prefSetString(App.KEY_LAST_NAME, editProfileModel!.items![0].lastName.toString());
        await Shared_Preferences.prefSetString(App.KEY_MOBILE_NUMBER, editProfileModel!.items![0].mobile.toString());
        Navigator.of(state!.context).pop();
      }
      commonToast(editProfileModel!.message.toString());
      // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Add Vendor Api Responce==========" + editProfileModel.toString());
    }
  }
}