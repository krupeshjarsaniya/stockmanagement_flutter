import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_request/edit_profile_request.dart';
import 'package:stoke_management/model/api_response/edit_profile_model.dart';
import 'package:stoke_management/screen/profile_screen.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/edit_profile_view_model.dart';
import 'package:stoke_management/widgets/common_toast.dart';

import '../app.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  String? USER_PROFILE;
  String DEVICE_TOKEN = "";
  String USER_ID = "";
  String DEVICE_ID = "";
  String DEVICE_TYPE = "";


  TextEditingController displayFirstNameController = TextEditingController();
  TextEditingController displayLastNameController = TextEditingController();
  TextEditingController displayMobileNumberController = TextEditingController();

  EditProfileViewModel? model;

  bool isLoading = false;
  String? firstName;
  String? lastName;
  String? mobileName;

  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(Duration.zero, () {
      (model = EditProfileViewModel(this));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Edit Profile",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              w_ImageProfile(),
              const SizedBox(height: 20,),
              w_buildDisplayTextField(),
              const SizedBox(height: 30,),
              w_SaveButton(),

            ],
          ),
        ),
      ),
    );
  }

  Widget w_ImageProfile(){
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(App.ic_profile,fit: BoxFit.fitHeight,),
        ),
      ),
    );
  }

  Widget w_buildDisplayTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: displayFirstNameController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
            alignLabelWithHint: true,
            labelText: "First Name",
          ),
        ),
         SizedBox(height: 20,),
        TextFormField(
          controller: displayLastNameController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
            alignLabelWithHint: true,
            labelText: "Last Name",
          ),
        ),
         SizedBox(height: 20,),
        TextFormField(
          controller: displayMobileNumberController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
            alignLabelWithHint: true,
            labelText: "Mobile Number",
          ),
        ),
      ],
    );
  }

  Widget w_TextField(){
    return Column(
      children:  const [
        TextField(
          decoration: InputDecoration(
              labelText: "First Name",
              labelStyle: TextStyle(fontSize: 14),
              hintText: "UserFirstName"),
        ),
        SizedBox(height: 20,),
        TextField(
          decoration: InputDecoration(
              labelText: "Last Name",
              labelStyle: TextStyle(fontSize: 14),
              hintText: "UserLastName"),
          ),
        SizedBox(height: 20,),
        TextField(
          decoration: InputDecoration(
              labelText: "Mobile Number",labelStyle: TextStyle(fontSize: 14), hintText: "Mobile Number"),

          ),
      ],
    );
  }

  Widget w_SaveButton() {
    return InkWell(
      onTap: () {


        if(displayFirstNameController.text.isEmpty){
          commonToast("Please Enter First Name");

        }else if(displayLastNameController.text.isEmpty){
          commonToast("Please Enter Last Name");

        }else if(displayMobileNumberController.text.isEmpty){
          commonToast("Please Enter Mobile Number");
        }
            model!.editProfileRequest =
                EditProfileRequest(
                  USER_ID.toString(),
                  displayFirstNameController.text.toString(),
                  displayLastNameController.text.toString(),
                  displayMobileNumberController.text.toString(),
                  "emailController.text.toString()",
                  DEVICE_TYPE.toString(),
                  DEVICE_ID.toString(),
                  DEVICE_TOKEN.toString(),
                );
            model!.callEditProfile(model!.editProfileRequest!);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
        Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
              ),),
          ),
        ),
      ),
    );
  }

  Future<Void?> init() async {
    var deviceToken = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceId = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var deviceType= await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    var userProfile= await Shared_Preferences.prefGetString(App.KEY_USER_PROFILE, "");
    var userFirstName= await Shared_Preferences.prefGetString(App.KEY_FIRST_NAME, "");
    var userLastName= await Shared_Preferences.prefGetString(App.KEY_LAST_NAME, "");
    var userMobileNumber= await Shared_Preferences.prefGetString(App.KEY_MOBILE_NUMBER, "");
    setState(() {
      DEVICE_TOKEN = deviceToken!;
      USER_ID = userId!;
      DEVICE_ID = deviceId!;
      DEVICE_TYPE = deviceType!;
      USER_PROFILE = userProfile!;
      firstName = userFirstName!;
      lastName = userLastName!;
      mobileName = userMobileNumber!;

      displayFirstNameController = TextEditingController(text: firstName.toString() );
      displayFirstNameController.selection = TextSelection.fromPosition(TextPosition(offset: displayFirstNameController.text.length));

      displayLastNameController = TextEditingController(text: lastName.toString() );
      displayLastNameController.selection = TextSelection.fromPosition(TextPosition(offset: displayLastNameController.text.length));

      displayMobileNumberController = TextEditingController(text: mobileName.toString() );
      displayMobileNumberController.selection = TextSelection.fromPosition(TextPosition(offset: displayMobileNumberController.text.length));

    });
  }

}
