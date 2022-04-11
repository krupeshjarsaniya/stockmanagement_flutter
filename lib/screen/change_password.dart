import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_request/change_password_request.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/change_password_viewmodel.dart';

import '../app.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  late ChangePasswordViewModel viewModel;
  TextEditingController oldPwdController =  TextEditingController();
  TextEditingController newPwdController =  TextEditingController();
  TextEditingController confirmPwdController =  TextEditingController();


  String? DEVICE_TYPE;
  String? DEVICE_ID;
  String? DEVICE_TOKEN;
  String? USER_ID;
  String? type;



  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = ChangePasswordViewModel(this));
    });
  }

  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceId = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var deviceToken = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");
    var deviceType = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    print("----userId---");
    print("----userId---" + userId.toString());

    setState(() {
      USER_ID = userId.toString();
      DEVICE_TOKEN = deviceToken.toString();
      DEVICE_ID= deviceId.toString();
      DEVICE_TYPE = deviceType.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorConstant.themColor,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 20,),
              w_TextField(),
              const SizedBox(height: 30,),
              w_ChangePwdButton(),
              // w_SaveButton(),

            ],
          ),
        ),
      ),
    );
  }

  Widget w_TextField(){
    return Column(
      children:  [
        TextFormField(
          controller: oldPwdController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
              alignLabelWithHint: true,
            labelText: ("Old Password"),
            labelStyle: TextStyle(
              fontSize: 15
            )
          ),
        ),

        const SizedBox(height: 20,),

        TextFormField(
          controller: newPwdController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
              alignLabelWithHint: true,
              labelText: ("New Password"),
              labelStyle: TextStyle(
                  fontSize: 15
              )
          ),
        ),

        const SizedBox(height: 20,),

        TextFormField(
          controller: confirmPwdController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
              alignLabelWithHint: true,
              labelText: ("Confirm Password"),
              labelStyle: TextStyle(
                  fontSize: 15
              )
          ),
        ),

      ],
    );
  }

  Widget w_ChangePwdButton() {
    return InkWell(
      onTap: () {

        if(oldPwdController.text.isEmpty){

        }else if(newPwdController.text.isEmpty){

        }else if(confirmPwdController.text.isEmpty){

        }else{

          viewModel.changePasswordRequest = ChangePasswordRequest(USER_ID.toString(), oldPwdController.text.toString(), newPwdController.text.toString(), confirmPwdController.text.toString(), DEVICE_TYPE.toString(), DEVICE_ID.toString(), DEVICE_TOKEN.toString());
          viewModel.callChangePassword(viewModel.changePasswordRequest!);
        }



        // Navigator.pushNamed(context, UtilRoutes.ProfileScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(6),
        ),
        child:  Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Text(
              "Change Password",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white
              ),),
          ),
        ),
      ),
    );
  }

}
