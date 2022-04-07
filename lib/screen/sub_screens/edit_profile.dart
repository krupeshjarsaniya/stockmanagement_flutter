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

import '../../app.dart';

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

  List<Item>? item = <Item>[];

  TextEditingController displayFirstNameController = TextEditingController();
  TextEditingController displayLastNameController = TextEditingController();
  TextEditingController displayMobileNumberController = TextEditingController();

  EditProfileViewModel? model;

  bool isLoading = false;

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
        title: Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
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
          child: Image.network(
              "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg"),
        ),
      ),
    );
  }

  Widget w_buildDisplayTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: displayFirstNameController,
          decoration: const InputDecoration(
            labelText: "First Name",
          ),
        ),
        const SizedBox(height: 20,),
        TextField(
          controller: displayLastNameController,
          decoration: const InputDecoration(
            labelText: "Last Name",
          ),
        ),
        const SizedBox(height: 20,),
        TextField(
          controller: displayMobileNumberController,
          decoration: const InputDecoration(
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
          if(displayFirstNameController.text.isNotEmpty){
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
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  (r) => false);
        };
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),),
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
    setState(() {
      DEVICE_TOKEN = deviceToken!;
      USER_ID = userId!;
      DEVICE_ID = deviceId!;
      DEVICE_TYPE = deviceType!;
      USER_PROFILE = userProfile!;
    });
  }

}
