
import 'package:stoke_management/model/api_request/edit_profile_request.dart';
import 'package:stoke_management/model/api_response/edit_profile_model.dart';
import 'package:stoke_management/screen/edit_profile.dart';
import 'package:stoke_management/services/interceptor_api.dart';

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
      state!.setState(() {
        state!.item = editProfileModel!.items;
      });
      // Navigator.pushReplacementNamed(state!.context, UtilRoutes.HomeScreen);
      print("==========Add Vendor Api Responce==========" + editProfileModel.toString());
    }
  }
}