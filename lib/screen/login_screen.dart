import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/login_view_model.dart';
import 'package:device_info/device_info.dart';
import '../app.dart';
import 'forgot_password_screen.dart';
// import 'package:stoke_management/widgets/common_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String DEVICE_TOKEN = "";

  TextEditingController phoneNumberController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  late LoginViewModel model;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String DEVICE_ID = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      /*model ??*/ (model = LoginViewModel(this));
    });
  }

  Future<void> initPlatformState() async {
    String deviceData = "";

    try {
      if (Platform.isAndroid) {
     _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      'Failed to get platform version.';
    }
    if (mounted) return;

    /* setState(() {
      _deviceData = deviceData;
    });*/
  }


  _readAndroidBuildData(AndroidDeviceInfo build) async{
    print("-->"+build.model);
    print("-->"+build.androidId);
    print("-->"+build.type);
    print("-->"+build.version.release.toString());
    print("-->"+build.device);

    model.logInRequest = UserLogInRequest(
        phoneNumberController.text.toString(),
        passwordController.text.toString(),
        "Android",
        build.androidId.toString(),
        DEVICE_TOKEN.toString(),
    );



    model.callUserLogIn(model.logInRequest!);
    /* model.addApns=AddApns("testmobile","1.0",build.androidId,await App.getToken(),build.model,build.device,build.version.release.toString(),"Android");
    model.callApns(model.addApns);*/
    print("=====DeviceId====="+build.androidId);
    Shared_Preferences.prefSetString(App.KEY_DEVICE_ID,build.androidId);
    Shared_Preferences.prefSetString(App.KEY_DEVICE_TYPE,"Android");
  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    print("-->"+data.model);
    print("-->"+data.name);
    print("-->"+data.systemVersion);
    print("-->"+data.utsname.version);
    print("-->"+data.systemName);
    print("-->"+data.identifierForVendor);
    model.logInRequest = UserLogInRequest(
        phoneNumberController.text.toString(),
        passwordController.text.toString(),
        "Ios",
        data.identifierForVendor,
        "xyz321",
    );
    model.callUserLogIn(model.logInRequest!);
    /* model.addApns=AddApns("testmobile", "1.0", data.identifierForVendor,"xyz321", data.name, data.model,  data.systemVersion, "Ios");
    model.callApns(model.addApns);*/
    Shared_Preferences.prefSetString(App.KEY_DEVICE_ID,data.identifierForVendor);
    Shared_Preferences.prefSetString(App.KEY_DEVICE_TYPE,"Ios");


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Login",style: AppBarTitle.myAppbarStyle,),
        // centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(5.0),
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                   SizedBox(
                    height: 20,
                  ),
                  wTextField(),
                   SizedBox(
                    height: 30,
                  ),
                  wLoginButton(),
                   SizedBox(
                    height: 40,
                  ),
                  wForgetPassword(),
                   SizedBox(
                    height: 20,
                  ),
                  wTextRegister()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget wTextField() {
    return Container(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: phoneNumberController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                  labelText: "Mobile",
                  fillColor: Colors.black,
                  // border: OutlineInputBorder(
                  //   borderRadius: new BorderRadius.circular(10),
                  //   borderSide: BorderSide(color: Colors.amber),
                  // )

              )),
           SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
              alignLabelWithHint: true,
                labelText: "Password",
                fillColor: Colors.black,
                // border: OutlineInputBorder(
                //     borderRadius: new BorderRadius.circular(10),
                //     borderSide: const BorderSide(color: Colors.red))

            ),
          ),
        ],
      ),
    );
  }

  Widget wLoginButton() {
    return GestureDetector(
      onTap: () {
        if(phoneNumberController.text.isEmpty){
          print("--phone_number_is_empty");
          // commonToast("Please Enter Mobile or Email Number");
        }else if(passwordController.text.isEmpty){
          print("--Password_number_is_empty");
          // commonToast("Please Enter Password");
        }else {


          initPlatformState();
          // loginViewModel.logInRequest =
          //     UserLogInRequest(phoneNumberController.text.toString(),
          //         passwordController.text.toString(),
          //         "sdfag",
          //         "fwef",
          //         "fraew");
          //
          // loginViewModel.callUserLogIn(loginViewModel.logInRequest!);
        }
        // Navigator.pushNamed(context, UtilRoutes.HomeScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget wForgetPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
      },
      child: const Text(
        "Forget Password ? ",
        style: TextStyle(
            color: ColorConstant.primarycolor, fontWeight: FontWeight.bold,fontSize: 15),
      ),
    );
  }

  Widget wTextRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Not Register Yet ?   ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontSize: 15),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, UtilRoutes.RegisterScreen);
          },
          child: const Text(
            "Register Now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstant.primarycolor,
                fontSize: 15
            ),
          ),
        )
      ],
    );
  }
}
