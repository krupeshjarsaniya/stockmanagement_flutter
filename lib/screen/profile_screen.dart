import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stoke_management/model/api_request/logout_request.dart';
import 'package:stoke_management/screen/change_password.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/screen/edit_profile.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/profile_viewmodel.dart';

import '../app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {

  late ProfileViewModel viewModel;
  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);

    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = ProfileViewModel(this));
    });
  }

  String? DEVICE_TYPE;
  String? DEVICE_ID;
  String? DEVICE_TOKEN;
  String? USER_ID;
  String? type;



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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("Profile", style: AppBarTitle.myAppbarStyle),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: ColorConstant.themColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: ColorConstant.themColor,
            statusBarIconBrightness: Brightness.light,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            w_UserDetail(),
            const SizedBox(height: 15,),
            w_ProfileSetting(),
            const SizedBox(height: 1.5,),
            w_PasswordSetting(),
            const SizedBox(height: 1.5,),
            w_PurchasePlan(),
            const SizedBox(height: 15,),
            w_Logout(context),
          ],
        ),
      ),
    );
  }


  Widget w_UserDetail() {
    return Container(
      height: 100,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.grey),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "User Name",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5,),
                  Text("useremailaddress@gmail.com"),
                ],
              ),
            )
          ],
        ),
    );
  }

  Widget w_ProfileSetting(){
    return InkWell(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => EditProfile()));
      },
      child: Container(
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:  [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: const Text(
                "Profile Settings"
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 15),
                child:
                const Icon(
                    Icons.keyboard_arrow_right,
                  color: Colors.grey,
                )
            )
          ],
        ),
      ),
    );
  }

  Widget w_PasswordSetting(){
    return InkWell(
      onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => ChangePassword()));
      },
      child: Container(
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:  [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: const Text(
                "Password Settings"
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 15),
                child:
                const Icon(
                    Icons.keyboard_arrow_right,
                  color: Colors.grey,

                )
            )
          ],
        ),
      ),
    );
  }

  Widget w_PurchasePlan(){
    return InkWell(
      onTap: (){},
      child: Container(
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:  [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: const Text(
                "Purchage Plan"
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget w_Logout(BuildContext context){
    return GestureDetector(
      onTap: (){
        print("---Logout---");
        // showAlertDialog(context);
        showDialog<String>(
            context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: const Text('Alert!'),
                content: const Text('Are you sure you want to logout?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () { return Navigator.pop(context, 'Cancel');},
                    child: const Text('cancel',style: TextStyle(color: Colors.black),),
                  ),
                  TextButton(
                    onPressed: () {

                      viewModel.logoutRequest = LogoutRequest(USER_ID.toString(), DEVICE_TYPE.toString(), DEVICE_ID.toString(), DEVICE_TOKEN.toString());
                      viewModel.callLogOut(viewModel.logoutRequest!);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            }
        );

      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: const Text(
            "Logout"
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = GestureDetector(
      child: Text("Yes",style: TextStyle(color: Colors.amber),),
      onTap: () {

        viewModel.logoutRequest = LogoutRequest(USER_ID.toString(), DEVICE_TYPE.toString(), DEVICE_ID.toString(), DEVICE_TOKEN.toString());
        viewModel.callLogOut(viewModel.logoutRequest!);
      },
    );


    Widget cancleButton = GestureDetector(
      child: Text("cancel",style: TextStyle(fontSize: 15),),
      onTap: () {
        Navigator.of(context).pop();
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancleButton,

        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}
